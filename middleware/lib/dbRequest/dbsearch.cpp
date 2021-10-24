#include "dbsearch.h"

QJsonObject *DBSearch::getReqest() const
{
    return reqest;
}

void DBSearch::setReqest(QJsonObject *newReqest)
{
    reqest = newReqest;
}

QJsonObject *DBSearch::getResult() const
{
    return result;
}

void DBSearch::setResult(QJsonObject *newResult)
{
    result = newResult;
}

DBSearch::DBSearch(QSqlDatabase *DB, QObject *parent)
{
    db = DB;
}

DBSearch::DBSearch(QSqlDatabase *DB, QJsonObject *Reqest, QJsonObject *Result, QObject *parent)
{
    db = DB;
    result = Result;
    reqest = Reqest;
}
