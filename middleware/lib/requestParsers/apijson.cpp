#include "apijson.h"

ApiJSON::ApiJSON(QObject* parent)
    : HttpRequestHandler(parent) {
    // empty
}

ApiJSON::~ApiJSON()
{
    delete requestObj;
    delete resultObj;
}

void ApiJSON::service(stefanfrings::HttpRequest &request, stefanfrings::HttpResponse &response)
{
    // request Data
    QByteArray requestData = request.getBody();
    QByteArray responseData = "";
    requestObj = new RequestType;
    resultObj = new ResultType;

    // Check Request data
    if(requestData.isEmpty() == true)
    {
        responseData = "No Request";
    }
    else
    {
        // convert to JSONDocument
        QJsonDocument jsonRequestDocument = QJsonDocument::fromJson(requestData);
        if(jsonRequestDocument.isObject() == false)
        {
            responseData = "No JSON Request";
        }
        else
        {
            // Convert to JSON Objekt
            QJsonObject jsonRequestObject = jsonRequestDocument.object();

            // Get and save sesponse
            QJsonObject jsonLastRequest = jsonRequestObject["request"].toObject();

            // Creat response objeckt
            QJsonObject jsonResult;

            // Check if request is already completed
            if(jsonLastRequest["completed"] == false)
            {
                // pars request
                requestObj->setRequest(jsonLastRequest);
                parsJSON(*requestObj, *resultObj);
                jsonResult = resultObj->getResult_values_AsJSON();
            }
            else
            {
                // return exiting result to client
                jsonResult = jsonRequestObject["result"].toObject();
            }

            // Creat final Json Objeckt and add request and response
            QJsonObject jsonResponse;
            jsonResponse.insert("request", jsonLastRequest);
            jsonResponse.insert("result", jsonResult);

            // Convert JSON to text
            QJsonDocument jsonResponseDocument(jsonResponse);
            responseData = jsonResponseDocument.toJson(QJsonDocument::Compact);
        }
    }


    response.setHeader("Content-Type", "application/json");
    response.setHeader("Out-Content-Length", responseData.length());
    response.setHeader("In-Content-Length", requestData.length());
    response.write(responseData,true);
}

void ApiJSON::parsJSON(RequestType& request, ResultType& response)
{
    // temp test code
    /*QJsonValue name = request.value("request_type");
    request["request_type"] = "42ABC42";
    result.insert("test", 42);*/

    // pars json and search DB
    dbRequest = new DBRequest(this);
    dbRequest->creatAndSendRequest(request, response);
    delete dbRequest;
}
