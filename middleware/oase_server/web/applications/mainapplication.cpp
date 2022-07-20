#include "mainapplication.h"

#include <stdio.h>

MainApplication::MainApplication(const Wt::WEnvironment& env): Wt::WApplication(env), session_(appRoot() + "host=127.0.0.1 port=5432 dbname=Assortment_System_Server_DB user=postgres")
{
    session_.login().changed().connect(this, &MainApplication::authEvent);

    useStyleSheet("css/style.css");
    auto theme = std::make_shared<Wt::WBootstrapTheme>();
    theme->setVersion(Wt::BootstrapVersion::v3);
    wApp->setTheme(theme);

    messageResourceBundle().use("strings");
    messageResourceBundle().use("templates");

    auto authWidget = Wt::cpp14::make_unique<AuthWidget>(session_);

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
        Wt::Dbo::Transaction t(session_);
        Wt::Dbo::ptr<User> user = session_.user();
        log("notice") << "(Favourite pet: " << user->favouritePet << ")";
    } else
    {
        log("notice") << "User logged out.";
    }
}
