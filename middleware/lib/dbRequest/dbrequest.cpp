#include "dbrequest.h"

void DBRequest::getAll(RequestType& request, ResultType& result)
{
    QList<QVariant> *partsArray = new QList<QVariant>; // creat result parts JSON Array
    if (dbOpenConOk) // check if an usable DB connection was opend
    {
        QSqlQuery qry(*db); // create an DB Querry
        QString table = request.value("which").toString(); // get witch table should be requested
        QString qryString = "SELECT * FROM " + table; // create Querry string

        qry.prepare(qryString); // give DB Querry the QRY string

        if(qry.exec()) // execute qry and check if it was sucsafull, if yes then pars the qry
        {
            QMap<QString, QVariant> *resMap = new QMap<QString, QVariant>; // this is the map that is used for te result values
            while(qry.next()) // go thrugh all qry elements and put them in to the partsArray
            {
                QMap<QString, QVariant> *partObject = new QMap<QString, QVariant>;
                QSqlRecord rec = qry.record();
                for(int i=0; i<rec.count(); ++i)
                {
                    partObject->insert(rec.fieldName(i), qry.value(i).toJsonValue());
                }
                QVariant *partValue = new QVariant(*partObject);
                partsArray->append(*partValue);
                delete partValue;
                delete partObject;
            }
            resMap->insert("parts", *partsArray);
            result.setResult_values(resMap);
            request.setCompleted(true); // Mark request as completed
        } else // when the qry was not sucsasfull than put an error
        {
            qDebug() << "Last querry error: " << qry.lastError().text();
            request.setCompleted(false); // Mark request as not completed
            result.setError(true, ("ERROR with DB Request; Last querry error: " + qry.lastError().text()));
        }
    }
    delete partsArray; // delet partsArray
}

void DBRequest::search(RequestType& request, ResultType& result)
{
    searchObj = new DBSearch(db, &request, &result, this); // creat DBSearch Object and giv it the db connection with the request and the result
    searchObj->searchStart(); // start searching the DB
    delete searchObj; // delet DBSearch Object after the search has ended
}

void DBRequest::initRequestMap()
{
    // no 0
    requestMap->insert("get_all", 1); // add get_all request type to map
    requestMap->insert("search", 2); // add search request type to map
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
    // cloase and remove DBConnection and free pointer
    db->close();
    QSqlDatabase::removeDatabase(dbCN);
    delete db;
}

void DBRequest::creatAndSendRequest(RequestType& request, ResultType& result)
{
    // look up requestMap and run correct Function
    switch (requestMap->value(request.getRequest_type()))
    {
        case 1:
            getAll(request, result);
        break;

        case 2:
            search(request, result);
        break;
    }
}
