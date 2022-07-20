#ifndef MAINAPPLICATION_H
#define MAINAPPLICATION_H
#include <Wt/WApplication.h>
#include <Wt/WEnvironment.h>
#include <Wt/WBootstrapTheme.h>
#include <Wt/WContainerWidget.h>

#include <Wt/Auth/AuthWidget.h>
#include <Wt/Auth/PasswordService.h>
#include <Wt/Auth/RegistrationWidget.h>

#include <Wt/WLineEdit.h>
#include <Wt/WPushButton.h>

#include <Wt/WBootstrapTheme.h>

#include "session.h"
#include "authwidget.h"


///
/// \brief The MainApplication class is the main class of the application(sesion) but only initilyses the authatication service where than the rest ist created when the user is loged in
///
class MainApplication : public Wt::WApplication
{
public:
    ///
    /// \brief MainApplication the contructor witsch starts the session
    /// \param env the enviorment variable
    ///
    MainApplication(const Wt::WEnvironment& env);

    ///
    /// \brief authEvent
    ///
    void authEvent();

private:
    // sesion:
    ///
    /// \brief session_ is the stored session of this application
    ///
    Session session_;

    // wigets pointer:
    ///
    /// \brief authWidget_ is the authentication widget pointer
    ///
    AuthWidget *authWidget_;

};
#endif // MAINAPPLICATION_H
