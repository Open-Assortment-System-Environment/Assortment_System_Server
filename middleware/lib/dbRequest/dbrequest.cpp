#include "dbrequest.h"

void DBRequest::getAll(QJsonObject &request, QJsonObject &result)
{
    //QJsonObject *parts = new QJsonObject;
    QJsonArray *partsArray = new QJsonArray;
    if (dbOpenConOk)
    {
        QSqlQuery qry(*db);
        QString table = request.value("which").toString();
        QString qryString = "SELECT * FROM " + table;

        qry.prepare(qryString);
        //qry.bindValue(":table", );

        if(qry.exec())
        {
            while(qry.next())
            {
                QJsonObject *partObject = new QJsonObject;
                QSqlRecord rec = qry.record();
                for(int i=0; i<rec.count(); ++i)
                {
                    partObject->insert(rec.fieldName(i), qry.value(i).toJsonValue());
                }
                QJsonValue *partValue = new QJsonValue(*partObject);
                partsArray->append(*partValue);
                delete partValue;
                delete partObject;
            }
            result.insert("parts", *partsArray);
        } else
        {
            qDebug() << "Last querry error: " << qry.lastError().text();
        }
    }
    delete partsArray;
}

void DBRequest::initRequestMap()
{
    // no 0
    requestMap->insert("get_all", 1);
    requestMap->insert("search", 2);
}

DBRequest::DBRequest(QObject *parent) : QObject(parent)
{
    // set lisstener settings objektc
    dbSettings = new QSettings(configFile, QSettings::IniFormat, parent);
    dbSettings->beginGroup("db_connection");

    // check if an old DBConnection with the same name already exists and if yes thean remove it
    if(QSqlDatabase::contains(dbCN))
    {
        QSqlDatabase::removeDatabase(dbCN);
    }

    // Creat and open DB connection
    db = new QSqlDatabase;
    *db = QSqlDatabase::addDatabase("QPSQL", dbCN);
    db->setHostName(dbSettings->value("HostName").toString());
    db->setDatabaseName(dbSettings->value("DatabaseName").toString());
    db->setUserName(dbSettings->value("UserName").toString());
    db->setPassword(dbSettings->value("Password").toString());
    dbOpenConOk = db->open();
    if(db->lastError().text().length() > 0)
    {
        qCritical() << "Last DB connection error: " << db->lastError().text();
    }

    // Initalice requestMap
    initRequestMap();
}

DBRequest::~DBRequest()
{
    // cloase DBConnection and free pointer
    db->close();
    delete db;
}

void DBRequest::creatAndSendRequest(QJsonObject &request, QJsonObject &result)
{
    // look up requestMap and run correct Function
    switch (requestMap->value(request.value("request_type").toString()))
    {
        case 1:
            getAll(request, result);
        break;
    }
}
