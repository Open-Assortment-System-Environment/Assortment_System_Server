#include "commandthread.h"

CommandThread::CommandThread(QCoreApplication *app)
{
    APP = app;
    initCommandMap();
}

CommandThread::~CommandThread()
{
    delete commandMap;
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

        case 2: //help command
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
void CommandThread::stopC1(QString parameters)
{
    if(parameters == "help") // checks if the command help is selekted and if yes than prints the help message
    {
        qInfo().noquote() << helpStopC1;
    }
    else // if not than it stops the Program
    {
        delete commandMap;
        delete staticFileController;
        qInfo().noquote() << "STOPING APP";
        this->deleteLater();
        APP->exit(0);
    }
}

void CommandThread::helpC2(QString parameters)
{
    if(parameters == "help") // checks if the command help is selekted and if yes than prints the help message
    {
        qInfo().noquote() << "Command: " << "help";
        qInfo().noquote() << "id: " << "2";
        qInfo().noquote() << helpHelpC2;
    }
    else if(parameters.length() > 0 && commandMap->value(parameters) != 0) // displays all helps of all commands
    {
        qInfo().noquote() << "Command: " << parameters; // displays the Command name
        qInfo().noquote() << "id: " << commandMap->value(parameters); // displays the Command id
        parsCommand(parameters, "help", true); // displays the Command help
    }
    else // displays all helps of of the specified commadn in the parameter commands
    {
        QList<QString> comKeys = commandMap->keys();
        foreach(QString key, comKeys)
        {
            qInfo().noquote() << "Command: " << key; // displays the Command name
            qInfo().noquote() << "id: " << commandMap->value(key); // displays the Command id
            parsCommand(key, "help", true); // displays the Command help
            qInfo().noquote() << "";

        }
    }
}
