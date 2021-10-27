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
    /// \brief reqestSearchBy is the array of values to be searched by
    ///
    QJsonArray *reqestSearchBy;
    ///
    /// \brief result is the result in to witch all is to be writen and than returned to the client
    ///
    QJsonObject *result;
    ///
    /// \brief error turns true if an error accurded while searching th DB
    ///
    bool error;
    ///
    /// \brief errorString the error that accured
    ///
    QString errorString;
    ///
    /// \brief searchWahtMap for identefien the id of what to search for(part, assambly, ...)
    ///
    QMap<QString, int> *searchWhatMap = new QMap<QString, int>;
    ///
    /// \brief searchTypeMap for identefien the id of the search type(from_to, value, ...)
    ///
    QMap<QString, int> *searchTypeMap = new QMap<QString, int>;

    // functions

    ///
    /// \brief initSearchWhatMap initalies the searchWhatMap with all the difrent types of searchable items
    ///
    void initSearchWhatMap();
    ///
    /// \brief initSearchTypeMap initalies the searchTypeMap with all the searchable types
    ///
    void initSearchTypeMap();

    ///
    /// \brief searchPart searches a part in the DB
    ///
    void searchParts();

    ///
    /// \brief searchPartsByAttribut returns a list of ids that have the Atribute with this value(search type: value)
    /// \param attribut the Atribut to be searched
    /// \param value the value it has to be
    /// \return the lsit of id's
    ///
    QList<QVariant> searchPartsByAttribut(QString attribut, QString value);
    ///
    /// \brief searchPartsByAttribut returns a list of ids that have the Atribute with this value(search type: from_to)
    /// \param attribut the Atribut to be searched
    /// \param valueFrom the value from where the range starts
    /// \param valueTo the value from where the list ends
    /// \return the lsit of id's
    ///
    QList<QVariant> searchPartsByAttribut(QString attribut, QString valueFrom, QString valueTo);
    ///
    /// \brief searchPartsByAttribut returns a list of ids that have the Atribute with this value(search type: value)
    /// \param attribut the Atribut to be searched
    /// \param value the values it has to be
    /// \return the lsit of id's
    ///
    QList<QVariant> searchPartsByAttribut(QString attribut, QList<QString> values);

    ///
    /// \brief searchPartsByAttribut returns a list of ids that have the Atribute with this value(search type: value) plus the only thoses that exist in the ids list
    /// \param ids the list of ids that is considerd
    /// \param attribut the Atribut to be searched
    /// \param value the value it has to be
    /// \return the lsit of id's
    ///
    QList<QVariant> searchPartsByAttribut(QList<QVariant> ids, QString attribut, QString value);
    ///
    /// \brief searchPartsByAttribut returns a list of ids that have the Atribute with this value(search type: from_to) plus the only thoses that exist in the ids list
    /// \param ids the list of ids that is considerd
    /// \param attribut the Atribut to be searched
    /// \param valueFrom the value from where the range starts
    /// \param valueTo the value from where the list ends
    /// \return the lsit of id's
    ///
    QList<QVariant> searchPartsByAttribut(QList<QVariant> ids, QString attribut, QString valueFrom, QString valueTo);
    ///
    /// \brief searchPartsByAttribut returns a list of ids that have the Atribute with this value(search type: value) plus the only thoses that exist in the ids list
    /// \param ids the list of ids that is considerd
    /// \param attribut the Atribut to be searched
    /// \param value the values it has to be
    /// \return the lsit of id's
    ///
    QList<QVariant> searchParByAttribut(QList<QVariant> ids, QString attribut, QList<QString> values);

    ///
    /// \brief searchPartsByAttributQuery runs the actual qry and is used by all the searchPartsByAttribut functions
    /// \param qryString the qry string to use
    /// \param ids the ids that are returned
    /// \return returns true if sucsasfull
    ///
    bool searchPartsByAttributQuery(QString qryString, QList<QVariant> &ids, QString &LastQryError);

    ///
    /// \brief creatIdsString creats the ids string for all the searchPartsByAttribut that get a list of ids that ar to be considerd
    /// \param ids the input list of ids
    /// \param idsString the output string
    /// \return returns true if all wend sucsesfull and if ther ar ids in it at all
    ///
    bool creatIdsString(QList<QVariant> &ids, QString &idsString);
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
