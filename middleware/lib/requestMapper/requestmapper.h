#ifndef REQUESTMAPPER_H
#define REQUESTMAPPER_H

// QtWebApp Includes
#include "httprequesthandler.h"
#include "apijson.h"

class RequestMapper : public stefanfrings::HttpRequestHandler {
    Q_OBJECT
public:
    RequestMapper(QObject* parent=0);
    void service(stefanfrings::HttpRequest& request, stefanfrings::HttpResponse& response);
};

#endif // REQUESTMAPPER_H
