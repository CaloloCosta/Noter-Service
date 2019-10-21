import ballerina/crypto;
import ballerina/http;
import ballerina/lang.'int as ints;
import ballerina/io;
// import ballerina/log;

int myPort = 9091; // change for every instance
// something more elegant may be needed here
string[] instance_ports = ["9091", "9092", "9093", "9094","9095"];

json ledger = {"data": "", "hash": "", "previous-hash": ""};
// maybe use database in future
json[] notices1 = [
    {"id": 1, 
    "topic": "server", 
    "description": "Ballerina server", 
    "day": 5, 
    "week": 2, 
    "month": 1,
    "submissionDate": "13/10/2019"
    },
    {"id": 2, 
    "topic": "secind test", 
    "description": "Ballerina server test", 
    "day": 5, 
    "week": 2, 
    "month": 1,
    "submissionDate": "13/10/2019"
    }
];
json[] notices2 = [
    {"id": 1, 
    "topic": "server", 
    "description": "Ballerina server", 
    "day": 5, 
    "week": 2, 
    "month": 1,
    "submissionDate": "13/10/2019"
    },
    {"id": 2, 
    "topic": "secind test", 
    "description": "Ballerina server test", 
    "day": 5, 
    "week": 2, 
    "month": 1,
    "submissionDate": "13/10/2019"
    }
];
json[] notices3 = [
    {"id": 1, 
    "topic": "server", 
    "description": "Ballerina server", 
    "day": 5, 
    "week": 2, 
    "month": 1,
    "submissionDate": "13/10/2019"
    },
    {"id": 2, 
    "topic": "secind test", 
    "description": "Ballerina server test", 
    "day": 5, 
    "week": 2, 
    "month": 1,
    "submissionDate": "13/10/2019"
    }
];
json[] notices4 = [
    {"id": 1, 
    "topic": "server", 
    "description": "Ballerina server", 
    "day": 5, 
    "week": 2, 
    "month": 1,
    "submissionDate": "13/10/2019"
    },
    {"id": 2, 
    "topic": "secind test", 
    "description": "Ballerina server test", 
    "day": 5, 
    "week": 2, 
    "month": 1,
    "submissionDate": "13/10/2019"
    }
];
json[] notices5 = [
    {"id": 1, 
    "topic": "server", 
    "description": "Ballerina server", 
    "day": 5, 
    "week": 2, 
    "month": 1,
    "submissionDate": "13/10/2019"
    },
    {"id": 2, 
    "topic": "secind test", 
    "description": "Ballerina server test", 
    "day": 5, 
    "week": 2, 
    "month": 1,
    "submissionDate": "13/10/2019"
    }
];

function lastIndex(json[] storage) returns int{
    string lastIndex = storage[storage.length() - 1].id.toString();
    int|error lIndex = ints:fromString(lastIndex);
    if( lIndex is int){
        return lIndex;
    }
    return 0;
}

listener http:Listener port1 = new(9091);
listener http:Listener port2 = new(9092);
listener http:Listener port3 = new(9093);
listener http:Listener port4 = new(9094);
listener http:Listener port5 = new(9095);
int count = 0;
int ledgerCount = 0;
@http:ServiceConfig {
    basePath: "/"
}

service noterService on port1, port2, port3, port4, port5{

        @http:ResourceConfig {
        path: "/gossip",
        methods: ["POST"]
    }
    // not tested
    resource function gossip(http:Caller caller, http:Request request) returns error? {
        http:Response res = new;
        json rawJSON = check request.getJsonPayload();
        io:println("From gossip: ",rawJSON);
        int port = caller.localAddress.port;
        if(port == 9091){
            io:println("i1");
            json notice = {
                "id": lastIndex(notices1)+1, 
                "topic": rawJSON.topic.toString(), 
                "description": rawJSON.description.toString(), 
                "day": rawJSON.day.toString(), 
                "week": rawJSON.week.toString(), 
                "month": rawJSON.month.toString(),
                "submissionDate": rawJSON.submissionDate.toString()
            };
 
                notices1.push(notice);  
                res.setPayload("All goog!");
                //res.setJsonPayload(<@untainted>notice, contentType = "application/json");
                check caller->respond(res);            
           
                   
        }
        else if(port == 9092){
            io:println("i2");
            json notice = {
                "id": lastIndex(notices1)+1, 
                "topic": rawJSON.topic.toString(), 
                "description": rawJSON.description.toString(), 
                "day": rawJSON.day.toString(), 
                "week": rawJSON.week.toString(), 
                "month": rawJSON.month.toString(),
                "submissionDate": rawJSON.submissionDate.toString()
            };
            
          
                notices2.push(notice);
                res.setPayload("All goog!");
                //res.setJsonPayload(<@untainted>notice, contentType = "application/json");
                check caller->respond(res); 
     
                   
        }
        else if(port == 9093){
            io:println("i3");
            json notice = {
                "id": lastIndex(notices1)+1, 
                "topic": rawJSON.topic.toString(), 
                "description": rawJSON.description.toString(), 
                "day": rawJSON.day.toString(), 
                "week": rawJSON.week.toString(), 
                "month": rawJSON.month.toString(),
                "submissionDate": rawJSON.submissionDate.toString()
            };
     
                notices3.push(notice);
                res.setPayload("All goog!");
                //res.setJsonPayload(<@untainted>notice, contentType = "application/json");
                check caller->respond(res); 
      
        }
        else if(port == 9094){
            io:println("i4");
            json notice = {
                "id": lastIndex(notices1)+1, 
                "topic": rawJSON.topic.toString(), 
                "description": rawJSON.description.toString(), 
                "day": rawJSON.day.toString(), 
                "week": rawJSON.week.toString(), 
                "month": rawJSON.month.toString(),
                "submissionDate": rawJSON.submissionDate.toString()
            };
          
                notices4.push(notice);
                res.setPayload("All goog!");
                //res.setJsonPayload(<@untainted>notice, contentType = "application/json");
                check caller->respond(res); 
   
        }
        else if(port == 9095){
            io:println("i5");
           json notice = {
                "id": lastIndex(notices1)+1, 
                "topic": rawJSON.topic.toString(), 
                "description": rawJSON.description.toString(), 
                "day": rawJSON.day.toString(), 
                "week": rawJSON.week.toString(), 
                "month": rawJSON.month.toString(),
                "submissionDate": rawJSON.submissionDate.toString()
            };
            
                notices5.push(notice);  
                res.setPayload("All goog!");
                //res.setJsonPayload(<@untainted>notice, contentType = "application/json");
                check caller->respond(res); 
            
        
        } 
    }

    @http:ResourceConfig {
        path: "/addNotice",
        methods: ["POST"]
    }

    // not tested
    resource function addNotice(http:Caller caller, http:Request request) returns error? {
        io:print(request);
        http:Response res = new;
        json rawJSON = check request.getJsonPayload();
        io:print(rawJSON);
        int port = caller.localAddress.port;
        if(port == 9091){
            json index = {"id": lastIndex(<@untainted>notices1)+1};
            json|error notice = rawJSON.mergeJson(index);
            if(notice is json){
                json ledger1 = ledgerHandle(notice);
                boolean valid = validate(ledger1);
                if(valid){
                    notices1.push(notice);
                    http:Client clientEP;
                    http:Response|error response;
                    
                    clientEP = new ("http://localhost:9092");
                    response = clientEP->post("/gossip", <@untainted>rawJSON);

                    clientEP = new ("http://localhost:9093");
                    response = clientEP->post("/gossip", <@untainted>rawJSON);

                    clientEP = new ("http://localhost:9094");
                    response = clientEP->post("/gossip", <@untainted>rawJSON);

                    clientEP = new ("http://localhost:9095");
                    response = clientEP->post("/gossip", <@untainted>rawJSON);
                    
                    ledger = <@untainted>ledger1;
                    io:println("Done!");
                    res.setJsonPayload(<@untainted>notice, contentType = "application/json");
                    check caller->respond(res);  
 
                }
            }
                   
        }
        else if (port == 9092){
            json index = {"id": lastIndex(<@untainted>notices2)+1};
            json|error notice = rawJSON.mergeJson(index);
            if(notice is json){
                json ledger2 = ledgerHandle(notice);
                boolean valid = validate(ledger2);
                if(valid){
                    notices2.push(notice);
                    http:Client clientEP;
                    http:Response|error response;
                    clientEP = new ("http://localhost:9091");
                    response = clientEP->post("/gossip", <@untainted>rawJSON);

                    clientEP = new ("http://localhost:9093");
                    response = clientEP->post("/gossip", <@untainted>rawJSON);

                    clientEP = new ("http://localhost:9094");
                    response = clientEP->post("/gossip", <@untainted>rawJSON);

                    clientEP = new ("http://localhost:9095");
                    response = clientEP->post("/gossip", <@untainted>rawJSON);

                    ledger = <@untainted>ledger2;
                    io:println("Done!");
                    res.setJsonPayload(<@untainted>notice, contentType = "application/json");
                    check caller->respond(res);  
                }
            }
        }
        else if (port == 9093){
            json index = {"id": lastIndex(<@untainted>notices3)+1};
            json|error notice = rawJSON.mergeJson(index);
            if(notice is json){
                json ledger3 = ledgerHandle(notice);
                boolean valid = validate(ledger3);
                if(valid){
                    notices3.push(notice);
                    http:Client clientEP;
                    http:Response|error response;
                    clientEP = new ("http://localhost:9092");
                    response = clientEP->post("/gossip", <@untainted>rawJSON);

                    clientEP = new ("http://localhost:9091");
                    response = clientEP->post("/gossip", <@untainted>rawJSON);

                    clientEP = new ("http://localhost:9094");
                    response = clientEP->post("/gossip", <@untainted>rawJSON);

                    clientEP = new ("http://localhost:9095");
                    response = clientEP->post("/gossip", <@untainted>rawJSON);
                    
                    ledger = <@untainted>ledger3;
                    io:println("Done!");
                    res.setJsonPayload(<@untainted>notice, contentType = "application/json");
                    check caller->respond(res);  
                }
                    
            }                  
        }
        else if (port == 9094){
            json index = {"id": lastIndex(<@untainted>notices4)+1};
            json|error notice = rawJSON.mergeJson(index);
            if(notice is json){
                json ledger4 = ledgerHandle(notice);
                boolean valid = validate(ledger4);
                if(valid){
                    notices4.push(notice);

                    http:Client clientEP;
                    http:Response|error response;
                    clientEP = new ("http://localhost:9092");
                    response = clientEP->post("/gossip", <@untainted>rawJSON);

                    clientEP = new ("http://localhost:9093");
                    response = clientEP->post("/gossip", <@untainted>rawJSON);

                    clientEP = new ("http://localhost:9091");
                    response = clientEP->post("/gossip", <@untainted>rawJSON);

                    clientEP = new ("http://localhost:9095");
                    response = clientEP->post("/gossip", <@untainted>rawJSON);

                    ledger = <@untainted>ledger4;
                io:println("Done!");
                    res.setJsonPayload(<@untainted>notice, contentType = "application/json");
                    check caller->respond(res);  
                    
                      
                }
            }
        }
        else if (port == 9095){
            json index = {"id": lastIndex(<@untainted>notices5)+1};
            json|error notice = rawJSON.mergeJson(index);
            if(notice is json){
                json ledger5 = ledgerHandle(notice);
                boolean valid = validate(ledger5);
                if(valid){
                    notices5.push(notice);

                    http:Client clientEP;
                    http:Response|error response;

                    clientEP = new ("http://localhost:9092");
                    response = clientEP->post("/gossip", <@untainted>rawJSON);

                    clientEP = new ("http://localhost:9093");
                    response = clientEP->post("/gossip", <@untainted>rawJSON);

                    clientEP = new ("http://localhost:9094");
                    response = clientEP->post("/gossip", <@untainted>rawJSON);

                    clientEP = new ("http://localhost:9091");
                    response = clientEP->post("/gossip", <@untainted>rawJSON);

                    ledger = <@untainted>ledger5;
                    io:println("Done!");
                    res.setJsonPayload(<@untainted>notice, contentType = "application/json");
                    check caller->respond(res);  
 
                }
            }
        }
            
        
              

    }

    @http:ResourceConfig {
        path: "/getNotices",
        methods: ["GET"]
    }
    // tested, and working
    resource function getNotices(http:Caller caller, http:Request request) returns error?{
        http:Response res = new;
        int port = caller.localAddress.port;
        if(port == 9091){
            res.setJsonPayload(<@untainted>notices1, contentType = "application/json");
            check caller->respond(res);
        }
        else if (port == 9092){
            res.setJsonPayload(<@untainted>notices2, contentType = "application/json");
            check caller->respond(res);
        }
        else if (port == 9093){
            res.setJsonPayload(<@untainted>notices3, contentType = "application/json");
            check caller->respond(res);
        }
        else if (port == 9094){
            res.setJsonPayload(<@untainted>notices4, contentType = "application/json");
            check caller->respond(res);
        }
        else if (port == 9095){
            res.setJsonPayload(<@untainted>notices5, contentType = "application/json");
            check caller->respond(res);
        }   
    }

    @http:ResourceConfig {
        path: "/getNotice/{id}",
        methods: ["GET"]
    }
    // tested and working
    resource function getNotice(http:Caller caller, http:Request request, int id) returns error?{
        http:Response res = new;
        json err = {"error": "Notice not found"};
        int port = caller.localAddress.port;
        if(port == 9091){
            foreach var notice in notices1 {
                if(notice.id == id){
                    res.setJsonPayload(<@untainted>notice, contentType = "application/json");
                    check caller->respond(res);
                }
            }
        }
        else if (port == 9092){
            foreach var notice in notices2 {
                if(notice.id == id){
                    res.setJsonPayload(<@untainted>notice, contentType = "application/json");
                    check caller->respond(res);
                }
            }
        }
        else if (port == 9093){
            foreach var notice in notices3 {
                if(notice.id == id){
                    res.setJsonPayload(<@untainted>notice, contentType = "application/json");
                    check caller->respond(res);
                }
            }
        }
        else if (port == 9094){
            foreach var notice in notices4 {
                if(notice.id == id){
                    res.setJsonPayload(<@untainted>notice, contentType = "application/json");
                    check caller->respond(res);
                }
            }
        }
        else if (port == 9095){
            foreach var notice in notices5 {
                if(notice.id == id){
                    res.setJsonPayload(<@untainted>notice, contentType = "application/json");
                    check caller->respond(res);
                }
            }
        }
        res.setJsonPayload(<@untainted>err, contentType = "application/json");
        check caller->respond(res);
        
    }

    @http:ResourceConfig {
        path: "/deleteNotice/{id}",
        methods: ["GET"]
    }
    resource function deleteNotice(http:Caller caller, http:Request request, int id) returns error?{
        http:Response res = new;
        json err = {"error": "Notice not found"};
        int port = caller.localAddress.port;
        if(port == 9091){
            int count = 0; 
            while (count < notices1.length()) {
                if(notices1[count].id == id){
                    json|error notice =   notices1.remove(count);

                    http:Client clientEP;
                    http:Response|error response;
                    string endpoint = "/gossipDelete"+id.toString();
                    
                    clientEP = new ("http://localhost:9092");
                    response = clientEP->get(<@untaitend>endpoint);
                    clientEP = new ("http://localhost:9093");
                    response = clientEP->get(<@untaitend>endpoint);
                    clientEP = new ("http://localhost:9094");
                    response = clientEP->get(<@untaitend>endpoint);
                    clientEP = new ("http://localhost:9095");
                    response = clientEP->get(<@untaitend>endpoint);

                    if(notice is json){
                        res.setJsonPayload(<@untainted>notice , contentType = "application/json");
                        check caller->respond(res);
                    }
                }
                count = count + 1;
            }
        }
        else if (port == 9092){
            int count = 0; 
            while (count < notices2.length()) {
                if(notices2[0].id == id){
                    json|error notice = notices2.remove(count);

                    http:Client clientEP;
                    http:Response|error response;
                    string endpoint = "/gossipDelete"+id.toString();
                    
                    clientEP = new ("http://localhost:9091");
                    response = clientEP->get(<@untaitend>endpoint);
                    clientEP = new ("http://localhost:9093");
                    response = clientEP->get(<@untaitend>endpoint);
                    clientEP = new ("http://localhost:9094");
                    response = clientEP->get(<@untaitend>endpoint);
                    clientEP = new ("http://localhost:9095");
                    response = clientEP->get(<@untaitend>endpoint);

                    if(notice is json){
                        res.setJsonPayload(<@untainted>notice , contentType = "application/json");
                        check caller->respond(res);
                    }
                }
                count = count + 1;
            }

        }
        else if (port == 9093){
            int count = 0; 
            while (count < notices3.length()) {
                if(notices3[0].id == id){
                    json|error notice = notices3.remove(count);
                    http:Client clientEP;
                    http:Response|error response;
                    string endpoint = "/gossipDelete"+id.toString();
                    
                    clientEP = new ("http://localhost:9092");
                    response = clientEP->get(<@untaitend>endpoint);
                    clientEP = new ("http://localhost:9091");
                    response = clientEP->get(<@untaitend>endpoint);
                    clientEP = new ("http://localhost:9094");
                    response = clientEP->get(<@untaitend>endpoint);
                    clientEP = new ("http://localhost:9095");
                    response = clientEP->get(<@untaitend>endpoint);
                    
                    if(notice is json){
                        res.setJsonPayload(<@untainted>notice , contentType = "application/json");
                        check caller->respond(res);
                    }
                }
                count = count + 1;
            }

        }
        else if (port == 9094){
            int count = 0; 
            while (count < notices4.length()) {
                if(notices4[0].id == id){
                    json|error notice = notices4.remove(count);

                    http:Client clientEP;
                    http:Response|error response;
                    string endpoint = "/gossipDelete"+id.toString();
                    
                    clientEP = new ("http://localhost:9092");
                    response = clientEP->get(<@untaitend>endpoint);
                    clientEP = new ("http://localhost:9093");
                    response = clientEP->get(<@untaitend>endpoint);
                    clientEP = new ("http://localhost:9091");
                    response = clientEP->get(<@untaitend>endpoint);
                    clientEP = new ("http://localhost:9095");
                    response = clientEP->get(<@untaitend>endpoint);
                    
                    if(notice is json){
                        res.setJsonPayload(<@untainted>notice , contentType = "application/json");
                        check caller->respond(res);
                    }
                }
                count = count + 1;
            }

        }
        else if (port == 9095){
            int count = 0; 
            while (count < notices5.length()) {
                if(notices5[0].id == id){
                    json|error notice = notices5.remove(count);

                    http:Client clientEP;
                    http:Response|error response;
                    string endpoint = "/gossipDelete"+id.toString();
                    
                    clientEP = new ("http://localhost:9092");
                    response = clientEP->get(<@untaitend>endpoint);
                    clientEP = new ("http://localhost:9093");
                    response = clientEP->get(<@untaitend>endpoint);
                    clientEP = new ("http://localhost:9094");
                    response = clientEP->get(<@untaitend>endpoint);
                    clientEP = new ("http://localhost:9091");
                    response = clientEP->get(<@untaitend>endpoint);
                    
                    if(notice is json){
                        res.setJsonPayload(<@untainted>notice , contentType = "application/json");
                        check caller->respond(res);
                    }
                }
                count = count + 1;
            }

        }

        res.setJsonPayload(<@untainted>err, contentType = "application/json");
        check caller->respond(res);

    }


 @http:ResourceConfig {
        path: "/gossipDelete/{id}",
        methods: ["GET"]
    }
    // not tested
    resource function gossipDelete(http:Caller caller, http:Request request, int id) returns error? {
        http:Response res = new;
        json err = {"error": "Notice not found"};
        int port = caller.localAddress.port;
        if(port == 9091){
            int count = 0; 
            while (count < notices1.length()) {
                if(notices1[0].id == id){
                    any|error notice = notices1.remove(count);
                    res.setPayload(<@untainted> id);
                    check caller->respond(res);
                }
                count = count + 1;
            }
        }
        else if (port == 9092){
            int count = 0; 
            while (count < notices2.length()) {
                if(notices2[0].id == id){
                    any|error notice = notices2.remove(count);
                    res.setPayload(<@untainted> id);
                    check caller->respond(res);
                }
                count = count + 1;
            }

        }
        else if (port == 9093){
            int count = 0; 
            while (count < notices3.length()) {
                if(notices3[0].id == id){
                    any|error notice = notices3.remove(count);
                    res.setPayload(<@untainted> id);
                    check caller->respond(res);
                }
                count = count + 1;
            }

        }
        else if (port == 9094){
            int count = 0; 
            while (count < notices4.length()) {
                if(notices4[0].id == id){
                    any|error notice = notices4.remove(count);
                    res.setPayload(<@untainted> id);
                    check caller->respond(res);
                }
                count = count + 1;
            }

        }
        else if (port == 9095){
            int count = 0; 
            while (count < notices5.length()) {
                if(notices5[0].id == id){
                    any|error notice = notices5.remove(count);
                    res.setPayload(<@untainted> id);
                    check caller->respond(res);
                }
                count = count + 1;
            }

        }
        count = 0;
    }

    @http:ResourceConfig {
        path: "/updateNotice",
        methods: ["POST"]
    }
    // not tested
    resource function updateNotice(http:Caller caller, http:Request request) returns error? {
        http:Response res = new;
        json rawJSON = check request.getJsonPayload();
        io:print("UPadte: ",rawJSON);
        int port = caller.localAddress.port;
        if(port == 9091){
            if(rawJSON.id != null){
                int count = 0;
                while(count < notices1.length()){
                    if(notices1[count].id.toString() == rawJSON.id.toString()){
                        notices2[count] = rawJSON;

                    http:Client clientEP;
                    http:Response|error response;
                    string endpoint = "/gossipUpdate/"+rawJSON.id.toString();
                    clientEP = new ("http://localhost:9092");
                    response = clientEP->post(<@untainted>endpoint, <@untainted>rawJSON);

                    clientEP = new ("http://localhost:9093");
                    response = clientEP->post(<@untainted>endpoint, <@untainted>rawJSON);

                    clientEP = new ("http://localhost:9094");
                    response = clientEP->post(<@untainted>endpoint, <@untainted>rawJSON);

                    clientEP = new ("http://localhost:9095");
                    response = clientEP->post(<@untainted>endpoint, <@untainted>rawJSON);
                    
                    res.setJsonPayload(<@untainted>rawJSON, contentType = "application/json");
                    check caller->respond(res);
                    }
                }

            }
        }

        else if(port == 9092){
            if(rawJSON.id != null){
                int count = 0;
                while(count < notices2.length()){
                    if(notices2[count].id.toString() == rawJSON.id.toString()){
                        
                        notices1[count] = rawJSON;

                    http:Client clientEP;
                    http:Response|error response;
                    string endpoint = "/gossipUpdate/"+rawJSON.id.toString();
                    clientEP = new ("http://localhost:9091");
                    response = clientEP->post(<@untainted>endpoint, <@untainted>rawJSON);

                    clientEP = new ("http://localhost:9093");
                    response = clientEP->post(<@untainted>endpoint, <@untainted>rawJSON);

                    clientEP = new ("http://localhost:9094");
                    response = clientEP->post(<@untainted>endpoint, <@untainted>rawJSON);

                    clientEP = new ("http://localhost:9095");
                    response = clientEP->post(<@untainted>endpoint, <@untainted>rawJSON);
                    
                    res.setJsonPayload(<@untainted>rawJSON, contentType = "application/json");
                    check caller->respond(res);
                    }
                }

            }
        }

        else if(port == 9093){
            if(rawJSON.id != null){
                int count = 0;
                while(count < notices3.length()){
                    if(notices3[count].id.toString() == rawJSON.id.toString()){
                       
                        notices3[count] = rawJSON;

                    http:Client clientEP;
                    http:Response|error response;
                    string endpoint = "/gossipUpdate/"+rawJSON.id.toString();
                    clientEP = new ("http://localhost:9092");
                    response = clientEP->post(<@untainted>endpoint, <@untainted>rawJSON);

                    clientEP = new ("http://localhost:9091");
                    response = clientEP->post(<@untainted>endpoint, <@untainted>rawJSON);

                    clientEP = new ("http://localhost:9094");
                    response = clientEP->post(<@untainted>endpoint, <@untainted>rawJSON);

                    clientEP = new ("http://localhost:9095");
                    response = clientEP->post(<@untainted>endpoint, <@untainted>rawJSON);
                    
                    res.setJsonPayload(<@untainted>rawJSON, contentType = "application/json");
                    check caller->respond(res);
                    }
                }

            }
        }
        else if(port == 9094){
            if(rawJSON.id != null){
                int count = 0;
                while(count < notices4.length()){
                    if(notices4[count].id.toString() == rawJSON.id.toString()){
                        
                        notices4[count] = rawJSON;

                    http:Client clientEP;
                    http:Response|error response;
                    string endpoint = "/gossipUpdate/"+rawJSON.id.toString();
                    clientEP = new ("http://localhost:9092");
                    response = clientEP->post(<@untainted>endpoint, <@untainted>rawJSON);

                    clientEP = new ("http://localhost:9091");
                    response = clientEP->post(<@untainted>endpoint, <@untainted>rawJSON);

                    clientEP = new ("http://localhost:9091");
                    response = clientEP->post(<@untainted>endpoint, <@untainted>rawJSON);

                    clientEP = new ("http://localhost:9095");
                    response = clientEP->post(<@untainted>endpoint, <@untainted>rawJSON);
                    
                    res.setJsonPayload(<@untainted>rawJSON, contentType = "application/json");
                    check caller->respond(res);
                    }
                }

            }
        }
        else if(port == 9095){
            if(rawJSON.id != null){
                int count = 0;
                while(count < notices5.length()){
                    if(notices5[count].id.toString() == rawJSON.id.toString()){
                     
                        notices5[count] = rawJSON;

                    http:Client clientEP;
                    http:Response|error response;
                    string endpoint = "/gossipUpdate/"+rawJSON.id.toString();
                    clientEP = new ("http://localhost:9092");
                    response = clientEP->post(<@untainted>endpoint, <@untainted>rawJSON);

                    clientEP = new ("http://localhost:9091");
                    response = clientEP->post(<@untainted>endpoint, <@untainted>rawJSON);

                    clientEP = new ("http://localhost:9094");
                    response = clientEP->post(<@untainted>endpoint, <@untainted>rawJSON);

                    clientEP = new ("http://localhost:9091");
                    response = clientEP->post(<@untainted>endpoint, <@untainted>rawJSON);
                    
                    res.setJsonPayload(<@untainted>rawJSON, contentType = "application/json");
                    check caller->respond(res);
                    }
                }

            }
        }
    }


        @http:ResourceConfig {
        path: "/gossipUpdate/{id}",
        methods: ["POST"]
    }
    // not tested
    resource function gossipUpdate(http:Caller caller, http:Request request, int id) returns error? {
        http:Response res = new;
        json rawJSON = check request.getJsonPayload();
        io:print(rawJSON);
        int port = caller.localAddress.port;
        if(port == 9091){ 
            int count = 0;
            while(count < notices1.length()){
                if(notices1[count].id.toString() == rawJSON.id.toString()){
                    notices1[count] = rawJSON;
                    res.setJsonPayload(<@untainted>rawJSON,contentType = "application/json");
                    check caller->respond(res);
                }
            }                   
        }

        else if(port == 9092){
            int count = 0;
            while(count < notices2.length()){
                if(notices2[count].id.toString() == rawJSON.id.toString()){
                    notices2[count] = rawJSON;
                    res.setJsonPayload(<@untainted>rawJSON,contentType = "application/json");
                    check caller->respond(res);
                }
            }     
        }

        else if(port == 9093){
            int count = 0;
            while(count < notices3.length()){
                if(notices3[count].id.toString() == rawJSON.id.toString()){
                    notices3[count] = rawJSON;
                    res.setJsonPayload(<@untainted>rawJSON,contentType = "application/json");
                    check caller->respond(res);
                }
            }     
        }
        else if(port == 9094){
            int count = 0;
            while(count < notices4.length()){
                if(notices4[count].id.toString() == rawJSON.id.toString()){
                    notices4[count] = rawJSON;
                    res.setJsonPayload(<@untainted>rawJSON,contentType = "application/json");
                    check caller->respond(res);
                }
            }     
        }
        else if(port == 9095){
            int count = 0;
            while(count < notices1.length()){
                if(notices5[count].id.toString() == rawJSON.id.toString()){
                    notices5[count] = rawJSON;
                    res.setJsonPayload(<@untainted>rawJSON,contentType = "application/json");
                    check caller->respond(res);
                }
            }     
        }
    }
}
function getSha512(string data) returns string {
    byte[] output = crypto:hashSha512(data.toBytes());
    return output.toString();
}

function ledgerHandle(json notice) returns json{
    ledgerCount = ledgerCount+ 1;
    json currentLedger = {
        "data": notice,
        "hash": getSha512(notice.toJsonString()),
        "previousHash": ledger.hash.toString(),
        "count": ledgerCount
    };
    io:println("\n\nledger count: ",ledgerCount);
    return currentLedger;
}

function validate(json currentLedger) returns boolean{
    if(currentLedger.previousHash == ledger.hash){
        io:println("Confirm ledger!");
        return true;
    }
    io:println("does not Confirm ledger!");
    return false;
}


