#ifndef DBREQUEST_H
#define DBREQUEST_H

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

#include "global.h"
#include "dbsearch.h"



class DBRequest : public QObject
{
    Q_OBJECT
private:
    ///
    /// \brief getAll creats the result with all values in an table specifyed in the request
    /// \param request
    /// \param result
    ///
    void getAll(QJsonObject& request, QJsonObject& result);

    ///
    /// \brief search creats the result with all values in an table specifyed in the request
    /// \param request
    /// \param result
    ///
    void search(QJsonObject& request, QJsonObject& result);

    ///
    /// \brief initRequestMap initalieses the requestMap with data
    ///
    void initRequestMap();

    ///
    /// \brief dbSettings ist the pointer to the setings for the DBConnection
    ///
    QSettings* dbSettings;
    ///
    /// \brief db is the DBconnection pointer
    ///
    QSqlDatabase *db;
    ///
    /// \brief dbCN is the name of the DB connection
    ///
    QString dbCN = "ASDBconnection";
    ///
    /// \brief dbOpenConOk is an bool for cheking if the DBConnection is open
    ///
    bool dbOpenConOk;
    ///
    /// \brief requestMap for identefien the id of the request
    ///
    /// get_all: 1<p>
    /// search: 2<p>
    ///
    QMap<QString, int> *requestMap = new QMap<QString, int>;
public:
    explicit DBRequest(QObject *parent = nullptr);
    ~DBRequest();
    void creatAndSendRequest(QJsonObject& request, QJsonObject& result);

signals:

};

#endif // DBREQUEST_H
