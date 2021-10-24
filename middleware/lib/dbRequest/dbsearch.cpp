#include "dbsearch.h"

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
