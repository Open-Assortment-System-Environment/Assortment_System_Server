#include "commandthread.h"

void CommandThread::stopC1(QString parameters)
{
    if(parameters == "help")
    {
        qInfo().noquote() << helpStopC1;
    }
    else
    {
        qInfo().noquote() << "STOPING APP";
        APP->exit(0);
    }
}
