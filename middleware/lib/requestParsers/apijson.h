#ifndef APIJSON_H
#define APIJSON_H

// Qt Includes
#include <QJsonDocument>
#include <QJsonObject>

// QtWebApp Includes
#include "httprequesthandler.h"

class ApiJSON : public stefanfrings::HttpRequestHandler
{
    Q_OBJECT
public:
    ApiJSON(QObject* parent=0);
    void service(stefanfrings::HttpRequest& request, stefanfrings::HttpResponse& response);
};

#endif // APIJSON_H
