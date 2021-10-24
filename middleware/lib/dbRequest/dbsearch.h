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
    ///
    /// \brief DBSearch the Constructor
    /// \param DB the DBConnection to be used
    /// \param parent qt parent Object
    ///
    explicit DBSearch(QSqlDatabase *DB ,QObject *parent = nullptr);
    ///
    /// \brief DBSearch the Constructor
    /// \param DB the DBConnection to be used
    /// \param Reqest the pointer to the Request Object
    /// \param Result the pointer to the Result Object
    /// \param parent qt parent Object
    ///
    explicit DBSearch(QSqlDatabase *DB, QJsonObject *Reqest, QJsonObject *Result, QObject *parent = nullptr);

    ///
    /// \brief searchStart starts the search thrugh the DB
    ///
    void searchStart();

    ///
    /// \brief getReqest returns the the pointer to the Reqest Object
    /// \return the Reqest Object pointer
    ///
    QJsonObject *getReqest() const;
    ///
    /// \brief setReqest sets the Request Object pointer
    /// \param newReqest the new Request Pointer
    ///
    void setReqest(QJsonObject *newReqest);

    ///
    /// \brief getResult returns the the pointer to the Result Object
    /// \return the Result Object pointer
    ///
    QJsonObject *getResult() const;
    ///
    /// \brief setResult sets the Result Object pointer
    /// \param newResult the new Result Pointer
    ///
    void setResult(QJsonObject *newResult);

signals:

};

#endif // DBSEARCH_H
