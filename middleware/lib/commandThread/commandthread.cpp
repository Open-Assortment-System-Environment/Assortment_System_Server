#include "commandthread.h"

CommandThread::CommandThread(QCoreApplication *app)
{
    APP = app;
    initCommandMap();
}

void CommandThread::run()
{
    while(true)
    {
        QTextStream s(stdin);
        QString value = s.readLine();
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

void CommandThread::initCommandMap()
{
    // no 0
    commandMap.insert("stop", 1);
    commandMap.insert("help", 2);
}

void CommandThread::parsCommand(QString comm, QString par, bool help)
{
    switch (commandMap[comm])
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
    qInfo() << "Unknown command";
}

void CommandThread::stopC1(QString parameters)
{
    if(parameters == "help")
    {
        qInfo() << helpStopC1;
    }
    else
    {
        qInfo() << "STOPING APP";
        APP->exit(0);
    }
}

void CommandThread::helpC2(QString parameters)
{
    if(parameters == "help")
    {
        qInfo() << "Command: " << "help";
        qInfo() << "id: " << "2";
        qInfo() << helpHelpC2;
    }
    else if(parameters.length() > 0 && commandMap[parameters] != 0)
    {
        qInfo() << "Command: " << parameters;
        qInfo() << "id: " << commandMap[parameters];
        parsCommand(parameters, "help", true);
    }
    else
    {
        QList<QString> comKeys = commandMap.keys();
        foreach(QString key, comKeys)
        {
            qInfo() << "Command: " << key;
            qInfo() << "id: " << commandMap[key];
            parsCommand(key, "help", true);

        }
    }
}
