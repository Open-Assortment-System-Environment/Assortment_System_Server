#include "resulttype.h"

bool ResultType::getError() const
{
    return error;
}

void ResultType::setError(bool newError)
{
    if(newError)
    {
        error = true;
    }
}

void ResultType::setError(bool newError, const QString &newErrorString)
{
    if(newError)
    {
        error = true;
    }
    errorString.append(newErrorString);
}

const QStringList &ResultType::getErrorString() const
{
    return errorString;
}

void ResultType::setErrorString(const QString &newErrorString)
{
    errorString.append(newErrorString);
}
QMap<QString, QVariant> ResultType::getResult_values() const
{
    return *result_values;
}

void ResultType::setResult_values(QMap<QString, QVariant> newResult_values)
{
    *result_values = newResult_values;
}

QJsonObject ResultType::getResult_values_AsJSON() const
{
    QJsonObject ret;
    if(error)
    {
        ret.insert("ERROR", error);
        QVariant varList = errorString;
        ret.insert("ERROR_STRING", varList.toJsonValue());
    } else
    {
        ret = QJsonObject::fromVariantMap(*result_values);
        ret.insert("ERROR", error);
    }
    return ret;
}

ResultType::ResultType(QObject *parent) : QObject(parent)
{

}

ResultType::~ResultType()
{
    delete result_values;
}
