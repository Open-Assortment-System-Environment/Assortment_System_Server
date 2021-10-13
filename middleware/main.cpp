// Qt Includes
#include <QApplication>

// QtWebApp Includes
#include "httplistener.h"
#include "staticfilecontroller.h"

// local Includes
#include "global_main.h"

// target Includes
#include "global.h"
#include "commandthread.h"
#include "requestmapper.h"
#include "dbrequest.h"


int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    // Displays the dirrectoy where the config is
    qInfo() << "Config dir: " << CONFIG_DIR;

    // Starts the Command Thread for listening on commands on the stdin
    CommandThread commandThread(&app);
    commandThread.start();

    // set configfile location
    configFile = CONFIG_DIR;
    configFile +=  "/config.ini";


    DBRequest ABC;
    ABC.test();

    // set lisstener settings objektc
    QSettings* listenerSettings = new QSettings(configFile, QSettings::IniFormat,&app);
    listenerSettings->beginGroup("listener");

    // Static file controller
    QSettings* fileSettings=new QSettings(configFile,QSettings::IniFormat,&app);
    fileSettings->beginGroup("files");
    fileSettings->setValue("path", PROGRMA_DATA);
    staticFileController=new stefanfrings::StaticFileController(fileSettings,&app);


    // Start the HTTP server
    new stefanfrings::HttpListener(listenerSettings,new RequestMapper(&app),&app);

    return app.exec();
}
