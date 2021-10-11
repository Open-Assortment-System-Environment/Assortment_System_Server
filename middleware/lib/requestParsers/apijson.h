#ifndef APIJSON_H
#define APIJSON_H

#include <QJsonDocument>
#include <QJsonObject>

#include "httprequesthandler.h"

class ApiJSON : public stefanfrings::HttpRequestHandler
{
    Q_OBJECT
public:
    ApiJSON(QObject* parent=0);
    void service(stefanfrings::HttpRequest& request, stefanfrings::HttpResponse& response);
};

#endif // APIJSON_H
