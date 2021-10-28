#ifndef RESULTTYPE_H
#define RESULTTYPE_H

#include <QObject>
#include <QVariant>

#include <QJsonDocument>
#include <QJsonParseError>
#include <QJsonObject>
#include <QJsonValue>
#include <QJsonArray>

class ResultType : public QObject
{
    Q_OBJECT
private:
    bool error = false;
    QString errorString = "";

    QMap<QString, QVariant> *result_values = new QMap<QString, QVariant>;
public:
    explicit ResultType(QObject *parent = nullptr);

    bool getError() const;
    void setError(bool newError);
    void setError(bool newError, const QString &newErrorString);

    const QString &getErrorString() const;
    void setErrorString(const QString &newErrorString);

    QMap<QString, QVariant> *getResult_values() const;
    void setResult_values(QMap<QString, QVariant> *newResult_values);


    QJsonObject getResult_values_AsJSON() const;

signals:

};

#endif // RESULTTYPE_H
