#include "dbrequest.h"

void DBRequest::getAll(QJsonObject &request, QJsonObject &result)
{
}

DBRequest::DBRequest(QObject *parent) : QObject(parent)
{
    // set lisstener settings objektc
    dbSettings = new QSettings(configFile, QSettings::IniFormat, parent);
    dbSettings->beginGroup("db_connection");

    db = new QSqlDatabase;
    db->addDatabase("QPSQL");
    db->setHostName(dbSettings->value("HostName").toString());
    db->setDatabaseName(dbSettings->value("DatabaseName").toString());
    db->setUserName(dbSettings->value("UserName").toString());
    db->setPassword(dbSettings->value("Password").toString());
    dbOpenConOk = db->open();
    qInfo() << dbOpenConOk;
    qInfo() << db->lastError();
}

void DBRequest::creatAndSendRequest(QJsonObject &request, QJsonObject &result)
{
}

void DBRequest::test()
{
    if (dbOpenConOk)
    {
        QSqlQuery query("SELECT id, name, description, weight, id_3d_models, type FROM parts.parts", *db);
        while (query.next())
        {
            qInfo() << "id: " << query.value(0).toString();
            qInfo() << "name: " << query.value(1).toString();
            qInfo() << "description: " << query.value(2).toString();
            qInfo() << "weight: " << query.value(3).toString();
            qInfo() << "id_3d_models: " << query.value(4).toString();
            qInfo() << "type: " << query.value(5).toString();
        }

        qDebug() << query.lastError().text();
    }
}
