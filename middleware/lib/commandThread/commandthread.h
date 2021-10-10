#ifndef COMMANDTHREAD_H
#define COMMANDTHREAD_H

#include <QThread>
#include <QDebug>
#include <QCoreApplication>


class CommandThread : public QThread
{
public:
    CommandThread(QCoreApplication *app);
private:
    ///
    /// \brief commandMap for identefien the id of the command
    ///
    QMap<QString, int> commandMap;
    ///
    /// \brief helpStopC1 help text of stop
    ///
    QString helpStopC1 = "Stops the Aplication";

    ///
    /// \brief helpHElpC2 help text of help
    ///
    QString helpHelpC2 = "Stops the Aplication";

    ///
    /// \brief APP the pointer to the QApplication
    ///
    QCoreApplication *APP;
    void run();

    ///
    /// \brief initCommandMap initalieses the commandMap with data
    ///
    void initCommandMap();

    ///
    /// \brief parsCommand runs the rigth function for the command
    /// \param command the commadn to pars
    /// \param parameter the parametes for the cammand
    ///
    void parsCommand(QString command, QString parameter, bool help = false);

    ///
    /// \brief unknownC0 displays the Unknown Command message
    ///
    /// id: 0<p>
    /// description:<p>
    /// displays the Unknown Command message
    ///
    void unknownC0();

    ///
    /// \brief stopC1 the stop command for stopping the App
    /// \param parameters the string of parameters
    ///
    /// Command: stop
    /// id: 1<p>
    /// description:<p>
    /// Stops the Aplication
    ///
    void stopC1(QString parameters);

    ///
    /// \brief helpC2 the help Command displays all helps
    /// \param parameters the string of parameters
    ///
    /// Command: help
    /// id: 2<p>
    /// description:<p>
    /// displays all helps
    ///
    void helpC2(QString parameters);
};

#endif // COMMANDTHREAD_H
