#include "requestmapper.h"

RequestMapper::RequestMapper(QObject* parent)
    : stefanfrings::HttpRequestHandler(parent) {
    // empty
}

void RequestMapper::service(stefanfrings::HttpRequest& request, stefanfrings::HttpResponse& response) {
    QByteArray path=request.getPath();
    qDebug("RequestMapper: path=%s",path.data());

    if (path=="/api/json") {
        ApiJSON().service(request, response);
    }
    else if (path.startsWith("/files")) {
        staticFileController->service(request,response);
    }
    else {
        response.setStatus(404,"Not found");
        response.write("The URL is wrong, no such document.",true);
    }

    qDebug("RequestMapper: finished request");
}

