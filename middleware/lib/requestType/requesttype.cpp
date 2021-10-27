#include "requesttype.h"

RequestType::RequestType(QObject *parent) : QObject(parent)
{
}

RequestType::RequestType(QJsonObject request, QObject *parent)
{
    setRequest(request);
}

void RequestType::setRequest(QJsonObject request)
{
    //set values that exist in all request and the remove them form the origonal to make it usable with foreach
    completed = request.value("completed").toBool();
    request.remove("completed");
    request_type = request.value("request_type").toString();
    request.remove("request_type");

    *request_type_values = request.toVariantMap(); // put all the other tuf in to this map
}

QJsonObject RequestType::getRequest()
{
    QJsonObject ret = QJsonObject::fromVariantMap(*request_type_values); // create an JSON Object based on the values map and than ister the base parameters
    ret.insert("completed", completed);
    ret.insert("request_type", request_type);
    return ret;
}

bool RequestType::getCompleted() const
{
    return completed;
}

void RequestType::setCompleted(bool newCompleted)
{
    completed = newCompleted;
}

const QString &RequestType::getRequest_type() const
{
    return request_type;
}

QVariant RequestType::value(QString &key)
{
    return request_type_values->value(key);
}
