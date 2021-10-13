#include "commandthread.h"

CommandThread::CommandThread(QCoreApplication *app)
{
    APP = app;
    initCommandMap();
}

void CommandThread::run()
{
    QTextStream in(stdin);
    while(true)
    {
        QString value = in.readLine();
        if(value.length() != 0)
        {
            QString comm = value;
            QString par = "";
            if(value.indexOf(":") > 0)
            {
                QStringList commANDpar = value.split(':');
                comm = commANDpar[0];
                par = commANDpar[1];
            }
            parsCommand(comm, par);
        }
    }
}

void CommandThread::initCommandMap()
{
    // no 0
    commandMap->insert("stop", 1);
    commandMap->insert("help", 2);
}

void CommandThread::parsCommand(QString comm, QString par, bool help)
{
    switch (commandMap->value(comm))
    {
        case 0: //when the Command is not known
            unknownC0();
        break;

        case 1: //stop command
            stopC1(par);
        break;

        case 2: //stop command
            if(!help)
            {
                helpC2(par);
            }
        break;
    }
}

void CommandThread::unknownC0()
{
    qInfo().noquote() << "Unknown command";
}
