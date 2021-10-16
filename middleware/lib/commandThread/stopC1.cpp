#include "commandthread.h"

void CommandThread::stopC1(QString parameters)
{
    if(parameters == "help")
    {
        qInfo().noquote() << helpStopC1;
    }
    else
    {
        delete commandMap;
        delete staticFileController;
        qInfo().noquote() << "STOPING APP";
        this->deleteLater();
        APP->exit(0);
    }
}
