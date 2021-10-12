#include "commandthread.h"

void CommandThread::helpC2(QString parameters)
{
    if(parameters == "help")
    {
        qInfo().noquote() << "Command: " << "help";
        qInfo().noquote() << "id: " << "2";
        qInfo().noquote() << helpHelpC2;
    }
    else if(parameters.length() > 0 && commandMap->value(parameters) != 0)
    {
        qInfo().noquote() << "Command: " << parameters;
        qInfo().noquote() << "id: " << commandMap->value(parameters);
        parsCommand(parameters, "help", true);
    }
    else
    {
        QList<QString> comKeys = commandMap->keys();
        foreach(QString key, comKeys)
        {
            qInfo().noquote() << "Command: " << key;
            qInfo().noquote() << "id: " << commandMap->value(key);
            parsCommand(key, "help", true);
            qInfo().noquote() << "";

        }
    }
}
