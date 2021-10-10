#include <QApplication>

#include "global_main.h"

#include "commandthread.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    qInfo() << "Config dir: " << CONFIG_DIR;

    CommandThread commandThread(&app);
    commandThread.start();

    return app.exec();
}
