#ifndef REQUESTTYPE_H
#define REQUESTTYPE_H

#include <QObject>
#include <QVariant>

#include <QJsonDocument>
#include <QJsonParseError>
#include <QJsonObject>
#include <QJsonValue>
#include <QJsonArray>


class RequestType : public QObject
{
    Q_OBJECT
private:
    // all requests
    ///
    /// \brief completed is set true after the request was fineshed
    ///
    bool completed = false;
    ///
    /// \brief request_type hier is the request type specefied
    ///
    QString request_type = "";

    // request_type specific values
    ///
    /// \brief request_type_values in this map there are all the other values that an request can have
    ///
    QMap<QString, QVariant> *request_type_values = new QMap<QString, QVariant>;

public:
    ///
    /// \brief RequestType the standart constructor
    /// \param parent the QT Parent objekt
    ///
    explicit RequestType(QObject *parent = nullptr);
    ///
    /// \brief RequestType the constructor
    /// \param request the request in JSON form
    /// \param parent the QT Parent objekt
    ///
    explicit RequestType(QJsonObject request, QObject *parent = nullptr);

    // JSON

    ///
    /// \brief setRequest sets the request from JSON data
    /// \param request the reqest as JSON data
    ///
    void setRequest(QJsonObject request);
    ///
    /// \brief getRequestAsJSON returns the request as JSON data
    /// \return the request as JSON data
    ///
    QJsonObject getRequestAsJSON();

    ///
    /// \brief getCompleted returns the completed status
    /// \return the status
    ///
    bool getCompleted() const;
    ///
    /// \brief setCompleted sets the completed status
    /// \param newCompleted the new status
    ///
    void setCompleted(bool newCompleted);

    ///
    /// \brief getRequest_type returns the type of this request
    /// \return the request type
    ///
    const QString &getRequest_type() const;

    ///
    /// \brief value returns the value that has the key
    /// \param key the key to use
    /// \return the value
    ///
    QVariant value(QString &key);

signals:

};


#endif // REQUESTTYPE_H
