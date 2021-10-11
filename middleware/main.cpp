#include <QApplication>

#include "global_main.h"

#include "commandthread.h"

#include "httplistener.h"

#include "requestmapper.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    // Displays the dirrectoy where the config is
    qInfo() << "Config dir: " << CONFIG_DIR;

    // Starts the Command Thread for listening on commands on the stdin
    CommandThread commandThread(&app);
    commandThread.start();

    QString configFile = CONFIG_DIR;
    configFile+=  "/config.ini";
    QSettings* listenerSettings = new QSettings(configFile, QSettings::IniFormat,&app);
    qDebug("config file loaded");

    listenerSettings->beginGroup("listener");

    // Start the HTTP server
    new HttpListener(listenerSettings,new RequestMapper(&app),&app);

    return app.exec();
}
