#include "resulttype.h"

bool ResultType::getError() const
{
    return error;
}

void ResultType::setError(bool newError)
{
    error = newError;
}

void ResultType::setError(bool newError, const QString &newErrorString)
{
    error = newError;
    errorString = newErrorString;
}

const QString &ResultType::getErrorString() const
{
    return errorString;
}

void ResultType::setErrorString(const QString &newErrorString)
{
    errorString = newErrorString;
}
QMap<QString, QVariant> *ResultType::getResult_values() const
{
    return result_values;
}

void ResultType::setResult_values(QMap<QString, QVariant> *newResult_values)
{
    result_values = newResult_values;
}

QJsonObject ResultType::getResult_values_AsJSON() const
{
    QJsonObject ret;
    if(error)
    {
        ret.insert("ERROR", error);
        ret.insert("ERROR_STRING", errorString);
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
