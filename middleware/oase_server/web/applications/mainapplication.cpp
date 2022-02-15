#include "mainapplication.h"

#include <stdio.h>

//MainApplication::MainApplication(const WEnvironment& env): WApplication(env), session_(appRoot() + "auth.db")
MainApplication::MainApplication(const WEnvironment& env): WApplication(env), session_(appRoot() + "host=127.0.0.1 port=5432 dbname=Assortment_System_Server_DB user=postgres")
{
    session_.login().changed().connect(this, &MainApplication::authEvent);

    useStyleSheet("css/style.css");
    messageResourceBundle().use("strings");
    messageResourceBundle().use("templates");

    auto authWidget = cpp14::make_unique<AuthWidget>(session_);

    authWidget->model()->addPasswordAuth(&Session::passwordAuth());
    authWidget->model()->addOAuth(Session::oAuth());
    authWidget->setRegistrationEnabled(true);//false);

    authWidget->processEnvironment();

    authWidget_ = root()->addWidget(std::move(authWidget));
}

void MainApplication::authEvent()
{
    if (session_.login().loggedIn()) {
        log("notice") << "User " << session_.login().user().id()
              << " logged in.";
        Dbo::Transaction t(session_);
        dbo::ptr<User> user = session_.user();
        log("notice") << "(Favourite pet: " << user->favouritePet << ")";
    } else
    {
        log("notice") << "User logged out.";
    }
}
