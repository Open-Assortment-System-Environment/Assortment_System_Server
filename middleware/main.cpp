#include <QApplication>

#include "global_main.h"

#include "commandthread.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    // Displays the dirrectoy where the config is
    qInfo() << "Config dir: " << CONFIG_DIR;

    // Starts the Command Thread for listening on commands on the stdin
    CommandThread commandThread(&app);
    commandThread.start();

    return app.exec();
}
