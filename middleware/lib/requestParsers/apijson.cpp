#include "apijson.h"

ApiJSON::ApiJSON(QObject* parent)
    : HttpRequestHandler(parent) {
    // empty
}

void ApiJSON::service(stefanfrings::HttpRequest &request, stefanfrings::HttpResponse &response)
{
    QByteArray requestData = request.getBody();
    qDebug() << "Body: " << requestData;
    QByteArray responseData = "";

    if(requestData.isEmpty() == true)
    {
        responseData = "No Request";
    }
    else
    {
        QJsonDocument jsonDocument = QJsonDocument::fromJson(requestData);
        if(jsonDocument.isObject() == false)
        {
            responseData = "No JSON Request";
        }
        else
        {

            QJsonObject object = jsonDocument.object();

            QJsonObject JSONrequest = object.value("request").toObject();
            QJsonValue name = JSONrequest.value("request_type");
            JSONrequest.insert("request_type", "42ABC42");
            object.insert("request", JSONrequest);
            QJsonDocument jsonRes;
            jsonRes.setObject(object);
            qDebug() << "RES: " << jsonRes.toJson(QJsonDocument::Compact);
            responseData = jsonRes.toJson(QJsonDocument::Compact);
        }
    }


    response.setHeader("Content-Type", "application/json");
    response.setHeader("Out-Content-Length", responseData.length());
    response.setHeader("In-Content-Length", requestData.length());
    response.write(responseData,true);
}
