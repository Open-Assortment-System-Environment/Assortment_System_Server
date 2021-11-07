#include "dbsearch.h"

void DBSearch::initSearchWhatMap()
{
    // no 0
    searchWhatMap->insert("parts", 1);
}

void DBSearch::initSearchTypeMap()
{
    // no 0
    searchTypeMap->insert("value", 1);
    searchTypeMap->insert("values", 2);
    searchTypeMap->insert("from_to", 3);
}

void DBSearch::searchParts()
{
    QList<QVariant> ids = getPartIds();
    QVariant partsList = getAllPartsWithAttributs(ids);
    QMap<QString, QVariant> partsMap;
    partsMap.insert("parts", partsList);
    result->setResult_values(partsMap);
    result->setError(error, errorString);
}

QList<QVariant> DBSearch::searchPartsByAttribut(QString attribut, QString value)
{
    QList<QVariant> ret;
    if((attribut.length() > 0) && (value.length() > 0))
    {
        QString qryString = "";
        if(partsBasicParameters->contains(attribut))
        {
            qryString = "SELECT id FROM parts.parts WHERE (" + attribut + " = '" + value + "') ORDER BY id ASC;";// create Querry string
        } else
        {
            qryString = "SELECT part_id FROM parts.properties WHERE (attribut = '" + attribut + "' AND value = '" + value + "') ORDER BY part_id ASC;";// create Querry string
        }
        QString lastQryError = "";
        if(!(searchPartsByAttributQuery(qryString, ret, lastQryError)))
        {
            qInfo() << "Last querry error: " << lastQryError;
            error = true;
            errorString = "Error while searching for id's: attribut[" + attribut + "]; value[" + value + "]; Last querry error: " + lastQryError;
        }
    } else
    {
        qInfo() << "No attribut or value to Search";
        error = true;
        errorString = "Error while searching for id's, no attribute or value to search: attribut[" + attribut + "]; value[" + value + "]";
    }
    return ret;
}

QList<QVariant> DBSearch::searchPartsByAttribut(QString attribut, QString valueFrom, QString valueTo)
{
    QList<QVariant> ret;
    if((attribut.length() > 0) && (valueFrom.length() > 0) && (valueTo.length() > 0))
    {
        QString qryString = "";// create Querry string variable
        if(partsBasicParameters->contains(attribut))
        {
            if(valueFrom < valueTo)
            {
                qryString = "SELECT id FROM parts.parts WHERE (" + attribut + " > '" + valueFrom + "' AND  " + attribut + " < '" + valueTo + "') ORDER BY id ASC;";// create Querry string
            }else
            {
                qryString = "SELECT id FROM parts.parts WHERE (" + attribut + " > '" + valueTo + "' AND " + attribut + " < '" + valueFrom + "') ORDER BY id ASC;";// create Querry string
            }
        } else
        {
            if(valueFrom < valueTo)
            {
                qryString = "SELECT part_id FROM parts.properties WHERE (attribut = '" + attribut + "' AND value > '" + valueFrom + "' AND value < '" + valueTo + "') ORDER BY part_id ASC;";// create Querry string
            }else
            {
                qryString = "SELECT part_id FROM parts.properties WHERE (attribut = '" + attribut + "' AND value > '" + valueTo + "' AND value < '" + valueFrom + "') ORDER BY part_id ASC;";// create Querry string
            }
        }

        QString lastQryError = "";
        if(!(searchPartsByAttributQuery(qryString, ret, lastQryError)))
        {
            qInfo() << "Last querry error: " << lastQryError;
            error = true;
            errorString = "Error while searching for id's: attribut[" + attribut + "]; valueFrom[" + valueFrom + "]; valueTo[" + valueTo + "]; Last querry error: " + lastQryError;
        }
    } else
    {
        qInfo() << "No attribut or value to Search";
        error = true;
        errorString = "Error while searching for id's: attribut[" + attribut + "]; valueFrom[" + valueFrom + "]; valueTo[" + valueTo + "]";
    }
    return ret;
}

QList<QVariant> DBSearch::searchPartsByAttribut(QString attribut, QList<QVariant> values)
{
    QList<QVariant> ret;
    bool noNullString = true;
    QString qryValues = "'";
    for(int i = 0; i < values.length(); i++)
    {
        if(values[i].toString().length() <= 0)
        {
            noNullString = false;
        } else if(i < (values.length() - 1))
        {
            qryValues.append(values[i].toString() + "', '");
        }if(i == (values.length() - 1))
        {
            qryValues.append(values[i].toString() + "'");
        }
    }
    if((attribut.length() > 0) && (values.length() > 0) && noNullString)
    {
        QString qryString = "";
        if(partsBasicParameters->contains(attribut))
        {
            qryString = "SELECT id FROM parts.parts WHERE (" + attribut + " IN (" + qryValues + ")) ORDER BY id ASC;";// create Querry string
        } else
        {
            qryString = "SELECT part_id FROM parts.properties WHERE (attribut = '" + attribut + "' AND value IN (" + qryValues + ")) ORDER BY part_id ASC;";// create Querry string
        }

        QString lastQryError = "";
        if(!(searchPartsByAttributQuery(qryString, ret, lastQryError)))
        {
            qInfo() << "Last querry error: " << lastQryError;
            error = true;
            errorString = "Error while searching for id's: attribut[" + attribut + "]; values[" + qryValues + "]; Last querry error: " + lastQryError;
        }
    } else
    {
        qInfo() << "No attribut or value to Search";
        error = true;
        errorString = "Error while searching for id's, no attribute or value to search: attribut[" + attribut + "]; values[" + qryValues + "]";
    }
    return ret;
}

QList<QVariant> DBSearch::searchPartsByAttribut(QString attribut, QString value, QList<QVariant> ids)
{
    QList<QVariant> ret;
    if((attribut.length() > 0) && (value.length() > 0))
    {
        QString idsString = "";
        if(creatIdsString(ids, idsString))
        {
            QString qryString = "";
            if(partsBasicParameters->contains(attribut))
            {
                qryString = "SELECT id FROM parts.parts WHERE (" + attribut + " = '" + value + "' AND id IN (" + idsString + ")) ORDER BY id ASC;";// create Querry string
            } else
            {
                qryString = "SELECT part_id FROM parts.properties WHERE (attribut = '" + attribut + "' AND value = '" + value + "' AND part_id IN (" + idsString + ")) ORDER BY part_id ASC;";// create Querry string
            }
            QString lastQryError = "";
            if(!(searchPartsByAttributQuery(qryString, ret, lastQryError)))
            {
                qInfo() << "Last querry error: " << lastQryError;
                error = true;
                errorString = "Error while searching for id's: attribut[" + attribut + "]; value[" + value + "]; Last querry error: " + lastQryError;
            }
        } else
        {
            qInfo() << "Error while preparing idsString";
            error = true;
            errorString = "Error while preparing idsString for DB Quearry";
        }
    } else
    {
        qInfo() << "No attribut or value to Search";
        error = true;
        errorString = "Error while searching for id's, no attribute or value to search: attribut[" + attribut + "]; value[" + value + "]";
    }
    return ret;
}

QList<QVariant> DBSearch::searchPartsByAttribut(QString attribut, QString valueFrom, QString valueTo, QList<QVariant> ids)
{
    QList<QVariant> ret;
    if((attribut.length() > 0) && (valueFrom.length() > 0) && (valueTo.length() > 0))
    {
        QString qryString = "";// create Querry string variable
        QString idsString = "";
        if(creatIdsString(ids, idsString))
        {
            if(partsBasicParameters->contains(attribut))
            {
                if(valueFrom < valueTo)
                {
                    qryString = "SELECT id FROM parts.parts WHERE (" + attribut + " > '" + valueFrom + "' AND  " + attribut + " < '" + valueTo + "' AND id IN (" + idsString + ")) ORDER BY id ASC;";// create Querry string
                }else
                {
                    qryString = "SELECT id FROM parts.parts WHERE (" + attribut + " > '" + valueTo + "' AND " + attribut + " < '" + valueFrom + "' AND id IN (" + idsString + ")) ORDER BY id ASC;";// create Querry string
                }
            } else
            {
                if(valueFrom < valueTo)
                {
                    qryString = "SELECT part_id FROM parts.properties WHERE (attribut = '" + attribut + "' AND value > " + valueFrom + " AND value < " + valueTo + " AND part_id IN (" + idsString + ")) ORDER BY part_id ASC;";// create Querry string
                }else
                {
                    qryString = "SELECT part_id FROM parts.properties WHERE (attribut = '" + attribut + "' AND value > " + valueTo + " AND value < " + valueFrom + " AND part_id IN (" + idsString + ")) ORDER BY part_id ASC;";// create Querry string
                }
            }

            QString lastQryError = "";
            if(!(searchPartsByAttributQuery(qryString, ret, lastQryError)))
            {
                qInfo() << "Last querry error: " << lastQryError;
                error = true;
                errorString = "Error while searching for id's: attribut[" + attribut + "]; valueFrom[" + valueFrom + "]; valueTo[" + valueTo + "]; Last querry error: " + lastQryError;
            }
        } else
        {
            qInfo() << "Error while preparing idsString";
            error = true;
            errorString = "Error while preparing idsString for DB Quearry";
        }
    } else
    {
        qInfo() << "No attribut or value to Search";
        error = true;
        errorString = "Error while searching for id's: attribut[" + attribut + "]; valueFrom[" + valueFrom + "]; valueTo[" + valueTo + "]";
    }
    return ret;
}

QList<QVariant> DBSearch::searchPartsByAttribut(QString attribut, QList<QVariant> values, QList<QVariant> ids)
{
    QList<QVariant> ret;
    bool noNullString = true;
    QString qryValues = "'";
    for(int i = 0; i < values.length(); i++)
    {
        if(values[i].toString().length() <= 0)
        {
            noNullString = false;
        } else if(i < (values.length() - 1))
        {
            qryValues.append(values[i].toString() + "', '");
        }if(i == (values.length() - 1))
        {
            qryValues.append(values[i].toString() + "'");
        }
    }
    if((attribut.length() > 0) && (values.length() > 0) && noNullString)
    {
        QString idsString = "";
        if(creatIdsString(ids, idsString))
        {
            QString qryString = "";
            if(partsBasicParameters->contains(attribut))
            {
                qryString = "SELECT id FROM parts.parts WHERE (" + attribut + " IN (" + qryValues + ") AND id IN (" + idsString + ")) ORDER BY id ASC;";// create Querry string
            } else
            {
                qryString = "SELECT part_id FROM parts.properties WHERE (attribut = '" + attribut + "' AND value IN (" + qryValues + ") AND part_id IN (" + idsString + ")) ORDER BY part_id ASC;";// create Querry string
            }
            qDebug() << "QRY String: " << qryString;

            QString lastQryError = "";
            if(!(searchPartsByAttributQuery(qryString, ret, lastQryError)))
            {
                qInfo() << "Last querry error: " << lastQryError;
                error = true;
                errorString = "Error while searching for id's: attribut[" + attribut + "]; values[" + qryValues + "]; Last querry error: " + lastQryError;
            }
        } else
        {
            qInfo() << "Error while preparing idsString";
            error = true;
            errorString = "Error while preparing idsString for DB Quearry";
        }
    } else
    {
        qInfo() << "No attribut or value to Search";
        error = true;
        errorString = "Error while searching for id's, no attribute or value to search: attribut[" + attribut + "]; value[" + qryValues + "]";
    }
    return ret;
}

bool DBSearch::searchPartsByAttributQuery(QString qryString, QList<QVariant> &ids, QString &lastQryError)
{
    QSqlQuery qry(*db); // create an DB Querry
    qry.prepare(qryString); // give DB Querry the QRY string

    if(qry.exec()) // execute qry and check if it was sucsafull, if yes then pars the qry
    {
        while(qry.next()) // go thrugh all qry elements and put them in to the partsArray
        {
            QVariant qryRetValue = qry.value(0); // gets the return value of the qry
            if((ids.length() == 0) || (!(ids.contains(qryRetValue)))) // checks if the value already exists of the if the list is empty
            {
                ids.append(qryRetValue); // appands the id to the return value
            }
        }
        return true;
    } else // when the qry was not sucsasfull than put an error
    {
        lastQryError = qry.lastError().text();
        return false;
    }
}

bool DBSearch::creatIdsString(QList<QVariant> &ids, QString &idsString)
{
    bool noError = true;
    if(ids.length() > 0)
    {
        idsString = "'";
        for(int i = 0; i < ids.length(); i++)
        {
            if(ids[i].toInt() < 0)
            {
                noError = false;
            } else if(i < (ids.length() - 1))
            {
                idsString.append(ids[i].toString() + "', '");
            }if(i == (ids.length() - 1))
            {
                idsString.append(ids[i].toString() + "'");
            }
        }
    } else
    {
        noError = false;
    }
    return noError;
}

QList<QVariant> DBSearch::getPartIds()
{
    QList<QVariant> ids;
    switch (searchTypeMap->value(reqeustSearchBy->at(0).toMap().value("type").toString()))
    {
        case 1: // value
            ids = searchPartsByAttribut(reqeustSearchBy->at(0).toMap().value("name").toString(), reqeustSearchBy->at(0).toMap().value("value").toString());
        break;

        case 2: // values
            ids = searchPartsByAttribut(reqeustSearchBy->at(0).toMap().value("name").toString(), reqeustSearchBy->at(0).toMap().value("values").toList());
        break;

        case 3: // from_to
            ids = searchPartsByAttribut(reqeustSearchBy->at(0).toMap().value("name").toString(), reqeustSearchBy->at(0).toMap().value("from").toString(), reqeustSearchBy->at(0).toMap().value("to").toString());
        break;
    }

    if(reqeustSearchBy->length() >= 1)
    {
        for(int i = 1; i < reqeustSearchBy->length(); i++)
        {
            switch (searchTypeMap->value(reqeustSearchBy->at(i).toMap().value("type").toString()))
            {
                case 1: // value
                    ids = searchPartsByAttribut(reqeustSearchBy->at(i).toMap().value("name").toString(), reqeustSearchBy->at(i).toMap().value("value").toString(), ids);
                break;

                case 2: // values
                    ids = searchPartsByAttribut(reqeustSearchBy->at(i).toMap().value("name").toString(), reqeustSearchBy->at(i).toMap().value("values").toList(), ids);
                break;

                case 3: // from_to
                    ids = searchPartsByAttribut(reqeustSearchBy->at(i).toMap().value("name").toString(), reqeustSearchBy->at(i).toMap().value("from").toString(), reqeustSearchBy->at(i).toMap().value("to").toString(), ids);
                break;
            }
        }
    }
    return ids;
}

QVariant DBSearch::getAllPartsWithAttributs(QList<QVariant> ids)
{
    QList<QVariant> *retList = new QList<QVariant>;
    foreach(QVariant id, ids)
    {
        retList->append(getPartWithAttributs(id));
    }
    QVariant ret(*retList);
    return ret;
}

QVariant DBSearch::getPartWithAttributs(QVariant id)
{
    QMap<QString, QVariant> *partObject = new QMap<QString, QVariant>;

    // first qry
    QString qryString1 = "SELECT * FROM parts.parts WHERE id = " + QString::number(id.toInt());
    QSqlQuery qry1(*db); // create an DB Querry
    qry1.prepare(qryString1); // give DB Querry the QRY string

    if(qry1.exec()) // execute qry and check if it was sucsafull, if yes then pars the qry
    {
        if(qry1.first())
        {
            QSqlRecord rec1 = qry1.record();
            for(int i=0; i<rec1.count(); ++i)
            {
                partObject->insert(rec1.fieldName(i), qry1.value(i).toJsonValue());
            }
            error = false;
        } else
        {
            errorString = "DB error, Last qry error: " + qry1.lastError().text();
            error = true;
        }
    } else // when the qry was not sucsasfull than put an error
    {
        errorString = "DB error, Last qry error: " + qry1.lastError().text();
        error = true;
    }

    // second qry
    QString qryString2 = "SELECT * FROM parts.properties WHERE part_id = " + QString::number(id.toInt());
    QSqlQuery qry2(*db); // create an DB Querry
    qry2.prepare(qryString2); // give DB Querry the QRY string

    if(qry2.exec()) // execute qry and check if it was sucsafull, if yes then pars the qry
    {
        QList<QVariant> *attributList = new QList<QVariant>;
        while(qry2.next()) // go thrugh all qry elements and put them in to the partsArray
        {
            QMap<QString, QVariant> *partAttributs = new QMap<QString, QVariant>;
            QSqlRecord rec2 = qry2.record();
            for(int i=0; i<rec2.count(); ++i)
            {
                partAttributs->insert("name", rec2.fieldName(i));
                partAttributs->insert("value", qry2.value(i).toJsonValue());
            }
            QVariant *partAttributsValue = new QVariant(*partAttributs);
            attributList->append(*partAttributsValue);
            error = false;
            delete partAttributsValue;
            delete partAttributs;
        }
        QVariant *attributListValue = new QVariant(*attributList);
        partObject->insert("custom_parameters", *attributListValue);
        delete attributList;
        delete attributListValue;
    } else // when the qry was not sucsasfull than put an error
    {
        errorString = "DB error, Last qry error: " + qry1.lastError().text();
        error = true;
    }

    QVariant ret(*partObject);
    delete partObject;
    return ret;
}

void DBSearch::initThis(QSqlDatabase *DB)
{
    db = DB;
    error = false;
    errorString = "";
    initSearchWhatMap();
    initSearchTypeMap();
    dbSearchSettings->beginGroup("db_search");

    QStringList partsAtributeValueString = dbSearchSettings->value("partsBasicParameters").toStringList();
    *partsBasicParameters = partsAtributeValueString;
}

DBSearch::DBSearch(QSqlDatabase *DB, QObject *parent)
{
    initThis(DB);
}

DBSearch::DBSearch(QSqlDatabase *DB, RequestType *Reqest, ResultType *Result, QObject *parent)
{
    result = Result;
    setReqest(Reqest);
    initThis(DB);
}

void DBSearch::searchStart()
{
    switch (searchWhatMap->value(reqest->value("search").toString()))
    {
        case 1: // parts
            searchParts();
        break;
    }
}

RequestType *DBSearch::getReqest() const
{
    return reqest;
}

void DBSearch::setReqest(RequestType *newReqest)
{
    reqest = newReqest;
    reqeustSearchBy = new QList<QVariant>;
    *reqeustSearchBy = reqest->value("by").toList();
}

ResultType *DBSearch::getResult() const
{
    return result;
}

void DBSearch::setResult(ResultType *newResult)
{
    result = newResult;
}

