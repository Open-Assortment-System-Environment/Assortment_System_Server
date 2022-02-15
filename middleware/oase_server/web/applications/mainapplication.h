#ifndef MAINAPPLICATION_H
#define MAINAPPLICATION_H
#include <Wt/WApplication.h>
#include <Wt/WEnvironment.h>
#include <Wt/WBootstrapTheme.h>
#include <Wt/WContainerWidget.h>

#include <Wt/Auth/AuthWidget.h>
#include <Wt/Auth/PasswordService.h>

#include <Wt/WLineEdit.h>
#include <Wt/WPushButton.h>

#include "session.h"
#include "authwidget.h"

#include <Wt/Auth/RegistrationWidget.h>

using namespace Wt;

class MainApplication : public WApplication
{
public:
  MainApplication(const WEnvironment& env);

  void authEvent();

private:
  // sesion:
  Session session_;

  // wigets pointer:
  AuthWidget *authWidget_;

};
#endif // MAINAPPLICATION_H
