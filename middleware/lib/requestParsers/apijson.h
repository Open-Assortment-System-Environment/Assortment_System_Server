#ifndef APIJSON_H
#define APIJSON_H

// Qt Includes
#include <QJsonDocument>
#include <QJsonObject>

// QtWebApp Includes
#include "httprequesthandler.h"

///
/// \brief The ApiJSON class parses and handels the JSON Api requests
///
class ApiJSON : public stefanfrings::HttpRequestHandler
{
    Q_OBJECT
private:
public:
    ///
    /// \brief ApiJSON the constructor
    /// \param parent Qobjekt parent
    ///
    ApiJSON(QObject* parent=0);

    ///
    /// \brief service ist the function that is called if a request comes in
    /// \param request the request
    /// \param response the respons to send
    ///
    void service(stefanfrings::HttpRequest& request, stefanfrings::HttpResponse& response);

    ///
    /// \brief parsJSON parses the Json requset
    /// \param request the request to pars
    /// \param response the reponse that is created
    ///
    void parsJSON(QJsonObject& request, QJsonObject& result);
};

#endif // APIJSON_H
