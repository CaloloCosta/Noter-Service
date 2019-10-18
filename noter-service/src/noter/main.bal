import ballerina/crypto;
import ballerina/http;
import ballerina/lang.'int;
import ballerina/log;

int myPort = 9092; // change for every instance
string[] instance_ports = ["9090", "9091", "9092"];//, "9093", "9094"];

map<json> ledger = {"data": "", "hash": "", "previous-hash": "", "height": 0};
// maybe use database in future
map<json> notices = {};
int count = 0;
@http:ServiceConfig {
    basePath: "/"
}

service noterService on new http:Listener(myPort) {

    @http:ResourceConfig {
        path: "/addNotice",
        methods: ["POST"]
    }
    resource function addNotice(http:Caller caller, http:Request request) returns error? {
        http:Response res = new;
        json rawJSON = check request.getJsonPayload();
        map<json> renderedJson = check map<json>.constructFrom(rawJSON);
        // get the fields
        string id = renderedJson["id"].toString();
        string topic = renderedJson["topic"].toString();
        string description = renderedJson["description"].toString();
        int day = check 'int:fromString(renderedJson["day"].toString());
        int weekNumber = check 'int:fromString(renderedJson["weekNumber"].toString());
        int month = check 'int:fromString(renderedJson["month"].toString());

        // add notice to storage, adding to ledger, gossip
        json notice = {"id": id, "topic": topic, "description": description, "day": day, "weekNumber": weekNumber, "month": month};
        notices[id] = notice;

        string noticeHash = getSha512(notice.toString());
        ledger["data"] = notice;
        // current becomes previous hash
        if(ledger["height"] != 0){
            ledger["previous-hash"] = ledger["hash"];
        }
        ledger["hash"] = noticeHash;
        count = count + 1;
        ledger["height"] = count;
        // no need to touch 'previous-hash'
        // gossip to other instances
        gossip();
        // return the data received as is
        res.setJsonPayload(<@untainted>rawJSON, contentType = "application/json");
        check caller->respond(res);
    }

    @http:ResourceConfig {
        path: "/getNotices",
        methods: ["GET"]
    }
    resource function getNotices(http:Caller caller, http:Request request) returns error?{
        http:Response res = new;
        res.setJsonPayload(<@untainted>notices, contentType = "application/json");
        check caller->respond(res);
    }

    @http:ResourceConfig {
        path: "/getNotice/{id}",
        methods: ["GET"]
    }
    resource function getNotice(http:Caller caller, http:Request request, string id) returns error?{
        http:Response res = new;
        if(notices.hasKey(id)){
            res.setJsonPayload(<@untainted>notices[id], contentType = "application/json");
        }else{
            // request from other instances
            json result = requestNotice(id);
            if(result == ""){
                res.setJsonPayload(<@untainted>"notice not found", contentType = "application/json");
            }else{
                res.setJsonPayload(<@untainted>result, contentType = "application/json");
            }
        }
        check caller->respond(res);
    }

     @http:ResourceConfig {
        path: "/internalFindNotice/{id}",
        methods: ["GET"]
    }
    resource function internalFindNotice(http:Caller caller, http:Request request, string id) returns error?{
        http:Response res = new;
        if(notices.hasKey(id)){
            res.setJsonPayload(<@untainted>notices[id], contentType = "application/json");
        }else{
            res.setJsonPayload(<@untainted>"", contentType = "application/json");
        }
        check caller->respond(res);
    }

    @http:ResourceConfig {
        path: "/updateNotice",
        methods: ["POST"]
    }
    resource function updateNotice(http:Caller caller, http:Request request) returns error? {
        http:Response res = new;
        json rawJSON = check request.getJsonPayload();
        map<json> renderedJson = check map<json>.constructFrom(rawJSON);
        // get the fields
        string id = renderedJson["id"].toString();
        string topic = renderedJson["topic"].toString();
        string description = renderedJson["description"].toString();
        var day = 'int:fromString(renderedJson["day"].toString());
        var weekNumber = 'int:fromString(renderedJson["weekNumber"].toString());
        var month = 'int:fromString(renderedJson["month"].toString());
        
        // make sure id exists
        if(notices.hasKey(id)){
            // carry out update to fields which are not empty
            if(topic != ""){
                map<json> m = <map<json>> notices[id];
                m["topic"] = topic;
                notices[id] = checkpanic json.constructFrom(m);                
            }
            if(description != ""){
                map<json> m = <map<json>> notices[id];
                m["description"] = description;
                notices[id] = checkpanic json.constructFrom(m);  
            }
            if(day is int){
                map<json> m = <map<json>> notices[id];
                m["day"] = day;
                notices[id] = checkpanic json.constructFrom(m);
            }
            if(weekNumber is int){
                map<json> m = <map<json>> notices[id];
                m["weekNumber"] = weekNumber;
                notices[id] = checkpanic json.constructFrom(m);
            }
            if(month is int){
                map<json> m = <map<json>> notices[id];
                m["month"] = month;
                notices[id] = checkpanic json.constructFrom(m);  
            }
            res.setJsonPayload(<@untainted>rawJSON, contentType = "application/json");
        }else {
            res.setJsonPayload("id not found", contentType = "application/json");
        }

        check caller->respond(res);
    }

    @http:ResourceConfig {
        path: "/deleteNotice/{id}",
        methods: ["GET"]
    }
    resource function deleteNotice(http:Caller caller, http:Request request, string id) returns error? {
        http:Response res = new;
        json rawJSON = check request.getJsonPayload();
        map<json> renderedJson = check map<json>.constructFrom(rawJSON);        
        // make sure id exists
        if(notices.hasKey(id)){
            var e = notices.remove(id);
            res.setJsonPayload(<@untainted>"delete successful", contentType = "application/json");
        }else{
            res.setJsonPayload(<@untainted>"id not found", contentType = "application/json");
        }
        check caller->respond(res);
    }

    @http:ResourceConfig {
        methods: ["POST"],
        path: "/validate"
    }

    resource function validate(http:Caller caller, http:Request req) returns error? {
        json jsonValue = checkpanic req.getJsonPayload();
        map<json> renderedJson = check map<json>.constructFrom(jsonValue);
        // The validation entails checking the hash of the previous ledger and the signature of
        // the current one
        // check if is genesis to us
        if(ledger["height"] == 0){
            // since we have nothing to compare with, just accept
            ledger["data"] = renderedJson["data"];
            ledger["hash"] = renderedJson["hash"];
            ledger["height"] = check 'int:fromString(ledger["height"].toString()) + 1;
            log:printInfo("ledger accepted as genesis");
        }else if(renderedJson["previous-hash"] == ledger["hash"]){
            ledger["previous-hash"] = ledger["hash"];
            ledger["data"] = renderedJson["data"];
            ledger["hash"] = renderedJson["hash"];
            ledger["height"] = check 'int:fromString(ledger["height"].toString()) + 1;
            log:printInfo("ledger accepted");
        }else{
            log:printInfo("ledger not accepted");
        }
        var x = caller -> ok();
    }
}

function getSha512(string data) returns string {
    byte[] output = crypto:hashSha512(data.toBytes());
    return output.toString();
}

function gossip() {
    foreach string p in instance_ports {
        if(p != myPort.toString()){
            http:Client clientEP = new ("http://localhost:" + p);
            var response = clientEP->post("/validate", <@untainted>ledger);
        }
    }
}

function requestNotice(string id) returns json{
    foreach string p in instance_ports {
        if(p != myPort.toString()){
            http:Client clientEP = new ("http://localhost:" + p);
            var response = clientEP->get("/internalFindNotice/"+id);
            if(response is http:Response){
                var x = response.getJsonPayload();
                if(x is json && x != "notice not found"){
                    return <@untainted>x;
                }
            }
        }
    }
    return "";
}

function requestAllNotices() returns json{
    json[] m = [];
    
    foreach string p in instance_ports {
        if(p != myPort.toString()){
            http:Client clientEP = new ("http://localhost:" + p);
            var response = clientEP->get("/getNotices");
            if(response is http:Response){
                var x = response.getJsonPayload();
                if(x is json){
                    m[m.length()] = x;
                }
            }
        }
    }
    return <@untainted>m;
}
