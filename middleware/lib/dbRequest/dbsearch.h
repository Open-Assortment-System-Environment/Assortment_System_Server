#ifndef DBSEARCH_H
#define DBSEARCH_H

#include <QObject>
#include <QSettings>

#include <QSqlQuery>
#include <QSqlResult>
#include <QSqlDriver>
#include <QSqlError>
#include <QSqlRecord>

#include <QJsonDocument>
#include <QJsonParseError>
#include <QJsonObject>
#include <QJsonValue>
#include <QJsonArray>

class DBSearch : public QObject
{
    Q_OBJECT
private:
    ///
    /// \brief db is the DBconnection pointer
    ///
    QSqlDatabase *db;
    ///
    /// \brief reqest is the request that is to be used and handeld
    ///
    QJsonObject *reqest;
    ///
    /// \brief result is the result in to witch all is to be writen and than returned to the client
    ///
    QJsonObject *result;
public:
    explicit DBSearch(QSqlDatabase *DB ,QObject *parent = nullptr);
    explicit DBSearch(QSqlDatabase *DB, QJsonObject *Reqest, QJsonObject *Result, QObject *parent = nullptr);

    void searchStart();

signals:

};

#endif // DBSEARCH_H
