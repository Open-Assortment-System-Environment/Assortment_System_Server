#ifndef REQUESTMAPPER_H
#define REQUESTMAPPER_H

// QtWebApp Includes
#include "httprequesthandler.h"
#include "apijson.h"


#include "global.h"

///
/// \brief The RequestMapper class maps the http request to the right location
///
class RequestMapper : public stefanfrings::HttpRequestHandler
{
    Q_OBJECT
public:
    ///
    /// \brief RequestMapper constuctor
    /// \param parent Qt parent variable
    ///
    RequestMapper(QObject* parent=0);

    ///
    /// \brief service is the function that is called when an request comes in
    /// \param request is the request
    /// \param response is the response
    ///
    void service(stefanfrings::HttpRequest& request, stefanfrings::HttpResponse& response);
};

#endif // REQUESTMAPPER_H
