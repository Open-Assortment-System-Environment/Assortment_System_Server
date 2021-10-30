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
#include "requesttype.h"
#include "resulttype.h"
#include "dbsearch.h"


///
/// \brief The DBRequest class creats and runs an request in the DB
///
class DBRequest : public QObject
{
    Q_OBJECT
private:
    ///
    /// \brief getAll creats the result with all values in an table specifyed in the request
    /// \param request
    /// \param result
    ///
    void getAll(RequestType& request, ResultType& result);

    ///
    /// \brief search creats the result with all values in an table specifyed in the request
    /// \param request
    /// \param result
    ///
    void search(RequestType& request, ResultType& result);

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

    ///
    /// \brief searchObj is an objekt to search for somthing in the DB
    ///
    DBSearch *searchObj;
public:
    ///
    /// \brief DBRequest is the basic constructor
    /// \param parent is the QT parent objekt
    ///
    explicit DBRequest(QObject *parent = nullptr);
    ~DBRequest();
    ///
    /// \brief creatAndSendRequest thakes the request makes an DB request out of it and models the reult data
    /// \param request the request data to use
    /// \param result the output result
    ///
    void creatAndSendRequest(RequestType& request, ResultType& result);

signals:

};

#endif // DBREQUEST_H
