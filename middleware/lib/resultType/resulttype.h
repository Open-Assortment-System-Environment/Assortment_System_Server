#ifndef RESULTTYPE_H
#define RESULTTYPE_H

#include <QObject>
#include <QVariant>

#include <QJsonDocument>
#include <QJsonParseError>
#include <QJsonObject>
#include <QJsonValue>
#include <QJsonArray>

///
/// \brief The ResultType class is an objeckt to manage and store the result data
///
class ResultType : public QObject
{
    Q_OBJECT
private:
    ///
    /// \brief error is set true if ther was an error while creating the result, simutalasy the completed marker in the request type should not be set true
    ///
    bool error = false;
    ///
    /// \brief errorString describs what has ben gone wronge
    ///
    QStringList errorString;

    ///
    /// \brief result_values are all the values that are containd in the result
    ///
    QMap<QString, QVariant> *result_values = new QMap<QString, QVariant>;
public:
    ///
    /// \brief ResultType is the basic constructor
    /// \param parent is the qt paren objekt
    ///
    explicit ResultType(QObject *parent = nullptr);
    ~ResultType();

    ///
    /// \brief getError returns the error state
    /// \return the error state
    ///
    bool getError() const;
    ///
    /// \brief setError sets the error state, can only set it true
    /// \param newError the new error state
    ///
    void setError(bool newError);
    ///
    /// \brief setError sets the error state with the errror string, can only set it true
    /// \param newError the new error state
    /// \param newErrorString the error string
    ///
    void setError(bool newError, const QString &newErrorString);

    ///
    /// \brief getErrorString returns the error string
    /// \return the error string
    ///
    const QStringList &getErrorString() const;
    ///
    /// \brief setErrorString sets the arror string(abbands an new error strin to a list)
    /// \param newErrorString the new error string
    ///
    void setErrorString(const QString &newErrorString);

    ///
    /// \brief getResult_values returns the raw values data not formated as JSOn or other
    /// \return the data
    ///
    QMap<QString, QVariant> getResult_values() const;
    ///
    /// \brief setResult_values sets the data
    /// \param newResult_values the new data
    ///
    void setResult_values(QMap<QString, QVariant> newResult_values);


    ///
    /// \brief getResult_values_AsJSON returns the data in JSON format
    /// \return the data as JSOn Objekt
    ///
    QJsonObject getResult_values_AsJSON() const;

signals:

};

#endif // RESULTTYPE_H
