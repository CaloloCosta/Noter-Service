import ballerina/http;
import ballerina/io;



json n = [
    {
    "id": 2,
    "topic": "DSP SERVER",
    "description": "Please Work"
    },
    {
    "id": 5,
    "topic": "Ballerina",
    "description": "Please Work"
    }
];


service noter on new http:Listener(9090){
    resource function getNotice(http:Caller caller, http:Request request){
        error? result = caller->respond(n);
        if(result is error){
            io:println("Error is responding ", result);
        }
    }
}