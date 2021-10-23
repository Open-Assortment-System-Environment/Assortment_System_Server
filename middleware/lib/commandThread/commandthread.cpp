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
        QString value = in.readLine(); // the read in value
        if(value.length() != 0) // cheches if sonthing was entered or not
        {
            QString comm = value; // the atcual command
            QString par = ""; // the parameters
            if(value.indexOf(":") > 0)
            {
                QStringList commANDpar = value.split(':'); // Splits the command from the parameters
                comm = commANDpar[0]; // writs the command in to the command variable
                par = commANDpar[1]; //writs the parameters in to the paramters variable
            }
            parsCommand(comm, par); // runs the pars function
        }
    }
}

void CommandThread::initCommandMap()
{
    // no 0
    commandMap->insert("stop", 1); // writs the stop command in to the command Map
    commandMap->insert("help", 2); // writs the help command in to the command Map
}

void CommandThread::parsCommand(QString comm, QString par, bool help)
{
    switch (commandMap->value(comm))
    {
        case 0: //when the Command is not known
            unknownC0(); // runs the unknwn command function
        break;

        case 1: //stop command
            stopC1(par); // runs the stop command function
        break;

        case 2: //help command
            if(!help) // runs the help command function if the help variable not true is
            {
                helpC2(par);
            }
        break;
    }
}

void CommandThread::unknownC0()
{
    qInfo().noquote() << "Unknown command, type help to see all posible commands"; // prints the Unknown Command function
}

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
