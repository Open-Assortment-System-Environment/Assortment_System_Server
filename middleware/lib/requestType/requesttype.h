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
    bool completed = false;
    QString request_type = "";

    // request_type specific values
    QMap<QString, QVariant> *request_type_values = new QMap<QString, QVariant>;

public:
    explicit RequestType(QObject *parent = nullptr);
    explicit RequestType(QJsonObject request, QObject *parent = nullptr);

    // JSON
    void setRequest(QJsonObject request);
    QJsonObject getRequest();

    bool getCompleted() const;
    void setCompleted(bool newCompleted);

    const QString &getRequest_type() const;

    QVariant value(QString &key);

signals:

};


#endif // REQUESTTYPE_H
