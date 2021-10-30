#ifndef APIJSON_H
#define APIJSON_H

// Qt Includes
#include <QJsonDocument>
#include <QJsonObject>

// QtWebApp Includes
#include "httprequesthandler.h"

#include "dbrequest.h"
#include "requesttype.h"
#include "resulttype.h"

///
/// \brief The ApiJSON class parses and handels the JSON Api requests
///
class ApiJSON : public stefanfrings::HttpRequestHandler
{
    Q_OBJECT
private:
    ///
    /// \brief requestObj is the pointer to the request data
    ///
    RequestType* requestObj;
    ///
    /// \brief resultObj is the pouinter to the responbse data
    ///
    ResultType* resultObj;

    ///
    /// \brief dbR is the pointer to the DB request
    ///
    DBRequest *dbRequest;

    ///
    /// \brief parsJSON parses the Json requset
    /// \param request the request to pars
    /// \param response the reponse that is created
    ///
    void parsJSON(RequestType& request, ResultType& response);
public:
    ///
    /// \brief ApiJSON the constructor
    /// \param parent Qobjekt parent
    ///
    ApiJSON(QObject* parent=0);
    ~ApiJSON();

    ///
    /// \brief service ist the function that is called if a request comes in
    /// \param request the request
    /// \param response the respons to send
    ///
    void service(stefanfrings::HttpRequest& request, stefanfrings::HttpResponse& response);
};

#endif // APIJSON_H
