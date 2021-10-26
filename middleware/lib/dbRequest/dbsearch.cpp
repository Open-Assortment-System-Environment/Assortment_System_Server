#include "dbsearch.h"

QJsonObject *DBSearch::getReqest() const
{
    return reqest;
}

void DBSearch::setReqest(QJsonObject *newReqest)
{
    reqest = newReqest;
}

QJsonObject *DBSearch::getResult() const
{
    return result;
}

void DBSearch::setResult(QJsonObject *newResult)
{
    result = newResult;
}

QList<QVariant> DBSearch::searchPartByAttribut(QString attribut, QString value)
{
    QList<QVariant> ret;
    if((attribut.length() > 0) && (value.length() > 0))
    {
        QString qryString = "SELECT part_id FFROM parts.properties WHERE (attribut = '" + attribut + "' AND value = '" + value + "') ORDER BY part_id ASC;";// create Querry string
        QString lastQryError = "";
        if(!(searchPartByAttributQuery(qryString, ret, lastQryError)))
        {
            qDebug() << "Last querry error: " << lastQryError;
            error = true;
            errorString = "Error while searching for id's: attribut[" + attribut + "]; value[" + value + "]; Last querry error: " + lastQryError;
        }
    } else
    {
        qDebug() << "No attribut or value to Search";
        error = true;
        errorString = "Error while searching for id's, no attribute or value to search: attribut[" + attribut + "]; value[" + value + "]";
    }
    return ret;
}

QList<QVariant> DBSearch::searchPartByAttribut(QString attribut, QString valueFrom, QString valueTo)
{
    QList<QVariant> ret;
    if((attribut.length() > 0) && (valueFrom.length() > 0) && (valueTo.length() > 0))
    {
        QString qryString = "";// create Querry string variable
        if(valueFrom < valueTo)
        {
            qryString = "SELECT part_id FFROM parts.properties WHERE (attribut = '" + attribut + "' AND value > '" + valueFrom + "' AND value < '" + valueTo + "') ORDER BY part_id ASC;";// create Querry string
        }else
        {
            qryString = "SELECT part_id FFROM parts.properties WHERE (attribut = '" + attribut + "' AND value > '" + valueTo + "' AND value < '" + valueFrom + "') ORDER BY part_id ASC;";// create Querry string
        }

        QString lastQryError = "";
        if(!(searchPartByAttributQuery(qryString, ret, lastQryError)))
        {
            qDebug() << "Last querry error: " << lastQryError;
            error = true;
            errorString = "Error while searching for id's: attribut[" + attribut + "]; valueFrom[" + valueFrom + "]; valueTo[" + valueTo + "]; Last querry error: " + lastQryError;
        }
    } else
    {
        qDebug() << "No attribut or value to Search";
        error = true;
        errorString = "Error while searching for id's: attribut[" + attribut + "]; valueFrom[" + valueFrom + "]; valueTo[" + valueTo + "]";
    }
    return ret;
}

QList<QVariant> DBSearch::searchPartByAttribut(QString attribut, QList<QString> values)
{
    QList<QVariant> ret;
    bool noNullString = true;
    QString qryValues = "'";
    for(int i = 0; i < values.length(); i++)
    {
        if(values[i].length() <= 0)
        {
            noNullString = false;
        } else if(i < (values.length() - 1))
        {
            qryValues.append(values[i] + "', ");
        }if(i == (values.length() - 1))
        {
            qryValues.append(values[i] + "'");
        }
    }
    if((attribut.length() > 0) && (values.length() > 0) && noNullString)
    {
        QString qryString = "SELECT part_id FFROM parts.properties WHERE (attribut = '" + attribut + "' AND value IN (" + qryValues + ")) ORDER BY part_id ASC;";// create Querry string

        QString lastQryError = "";
        if(!(searchPartByAttributQuery(qryString, ret, lastQryError)))
        {
            qDebug() << "Last querry error: " << lastQryError;
            error = true;
            errorString = "Error while searching for id's: attribut[" + attribut + "]; value[" + qryValues + "]; Last querry error: " + lastQryError;
        }
    } else
    {
        qDebug() << "No attribut or value to Search";
        error = true;
        errorString = "Error while searching for id's, no attribute or value to search: attribut[" + attribut + "]; value[" + qryValues + "]";
    }
    return ret;
}

QList<QVariant> DBSearch::searchPartByAttribut(QList<QVariant> ids, QString attribut, QString value)
{
    QList<QVariant> ret;
    if((attribut.length() > 0) && (value.length() > 0))
    {
        QString idsString = "";
        if(creatIdsString(ids, idsString))
        {
            QString qryString = "SELECT part_id FFROM parts.properties WHERE (attribut = '" + attribut + "' AND value = '" + value + "' AND part_id IN (" + idsString + ")) ORDER BY part_id ASC;";// create Querry string
            QString lastQryError = "";
            if(!(searchPartByAttributQuery(qryString, ret, lastQryError)))
            {
                qDebug() << "Last querry error: " << lastQryError;
                error = true;
                errorString = "Error while searching for id's: attribut[" + attribut + "]; value[" + value + "]; Last querry error: " + lastQryError;
            }
        } else
        {
            qDebug() << "Error while preparing idsString";
            error = true;
            errorString = "Error while preparing idsString for DB Quearry";
        }
    } else
    {
        qDebug() << "No attribut or value to Search";
        error = true;
        errorString = "Error while searching for id's, no attribute or value to search: attribut[" + attribut + "]; value[" + value + "]";
    }
    return ret;
}

QList<QVariant> DBSearch::searchPartByAttribut(QList<QVariant> ids, QString attribut, QString valueFrom, QString valueTo)
{
    QList<QVariant> ret;
    if((attribut.length() > 0) && (valueFrom.length() > 0) && (valueTo.length() > 0))
    {
        QString qryString = "";// create Querry string variable
        QString idsString = "";
        if(creatIdsString(ids, idsString))
        {
            if(valueFrom < valueTo)
            {
                qryString = "SELECT part_id FFROM parts.properties WHERE (attribut = '" + attribut + "' AND value > '" + valueFrom + "' AND value < '" + valueTo + "' AND part_id IN (" + idsString + ")) ORDER BY part_id ASC;";// create Querry string
            }else
            {
                qryString = "SELECT part_id FFROM parts.properties WHERE (attribut = '" + attribut + "' AND value > '" + valueTo + "' AND value < '" + valueFrom + "' AND part_id IN (" + idsString + ")) ORDER BY part_id ASC;";// create Querry string
            }

            QString lastQryError = "";
            if(!(searchPartByAttributQuery(qryString, ret, lastQryError)))
            {
                qDebug() << "Last querry error: " << lastQryError;
                error = true;
                errorString = "Error while searching for id's: attribut[" + attribut + "]; valueFrom[" + valueFrom + "]; valueTo[" + valueTo + "]; Last querry error: " + lastQryError;
            }
        } else
        {
            qDebug() << "Error while preparing idsString";
            error = true;
            errorString = "Error while preparing idsString for DB Quearry";
        }
    } else
    {
        qDebug() << "No attribut or value to Search";
        error = true;
        errorString = "Error while searching for id's: attribut[" + attribut + "]; valueFrom[" + valueFrom + "]; valueTo[" + valueTo + "]";
    }
    return ret;
}

QList<QVariant> DBSearch::searchParByAttribut(QList<QVariant> ids, QString attribut, QList<QString> values)
{
    QList<QVariant> ret;
    bool noNullString = true;
    QString qryValues = "'";
    for(int i = 0; i < values.length(); i++)
    {
        if(values[i].length() <= 0)
        {
            noNullString = false;
        } else if(i < (values.length() - 1))
        {
            qryValues.append(values[i] + "', ");
        }if(i == (values.length() - 1))
        {
            qryValues.append(values[i] + "'");
        }
    }
    if((attribut.length() > 0) && (values.length() > 0) && noNullString)
    {
        QString idsString = "";
        if(creatIdsString(ids, idsString))
        {
            QString qryString = "SELECT part_id FFROM parts.properties WHERE (attribut = '" + attribut + "' AND value IN (" + qryValues + ") AND part_id IN (" + idsString + ")) ORDER BY part_id ASC;";// create Querry string

            QString lastQryError = "";
            if(!(searchPartByAttributQuery(qryString, ret, lastQryError)))
            {
                qDebug() << "Last querry error: " << lastQryError;
                error = true;
                errorString = "Error while searching for id's: attribut[" + attribut + "]; value[" + qryValues + "]; Last querry error: " + lastQryError;
            }
        } else
        {
            qDebug() << "Error while preparing idsString";
            error = true;
            errorString = "Error while preparing idsString for DB Quearry";
        }
    } else
    {
        qDebug() << "No attribut or value to Search";
        error = true;
        errorString = "Error while searching for id's, no attribute or value to search: attribut[" + attribut + "]; value[" + qryValues + "]";
    }
    return ret;
}

bool DBSearch::searchPartByAttributQuery(QString qryString, QList<QVariant> &ids, QString &lastQryError)
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
                idsString.append(ids[i].toString() + "', ");
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

DBSearch::DBSearch(QSqlDatabase *DB, QObject *parent)
{
    db = DB;
    error = false;
    errorString = "";
}

DBSearch::DBSearch(QSqlDatabase *DB, QJsonObject *Reqest, QJsonObject *Result, QObject *parent)
{
    db = DB;
    result = Result;
    reqest = Reqest;
    error = false;
    errorString = "";
}
