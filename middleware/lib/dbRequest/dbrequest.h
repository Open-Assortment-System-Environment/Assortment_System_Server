#ifndef DBREQUEST_H
#define DBREQUEST_H

#include <QObject>
#include <QSettings>
#include <QSqlQuery>
#include <QSqlResult>
#include <QSqlDriver>
#include <QSqlError>

#include "global.h"

class DBRequest : public QObject
{
    Q_OBJECT
private:
    void getAll(QJsonObject& request, QJsonObject& result);

    QSettings* dbSettings;
    QSqlDatabase *db;
    bool dbOpenConOk;
public:
    explicit DBRequest(QObject *parent = nullptr);
    void creatAndSendRequest(QJsonObject& request, QJsonObject& result);
    void test();

signals:

};

#endif // DBREQUEST_H
