/*
 * Copyright (C) 2008 Emweb bv, Herent, Belgium.
 *
 * See the LICENSE file for terms of use.
 */

#include "session.h"

#include "Wt/Auth/AuthService.h"
#include "Wt/Auth/HashFunction.h"
#include "Wt/Auth/PasswordService.h"
#include "Wt/Auth/PasswordStrengthValidator.h"
#include "Wt/Auth/PasswordVerifier.h"
#include "Wt/Auth/GoogleService.h"
#include "Wt/Auth/FacebookService.h"
#include "Wt/Auth/Dbo/AuthInfo.h"
#include "Wt/Auth/Dbo/UserDatabase.h"

//#include "Wt/Dbo/backend/Sqlite3.h"
#include "Wt/Dbo/backend/Postgres.h"

namespace {

  Wt::Auth::AuthService myAuthService;
  Wt::Auth::PasswordService myPasswordService(myAuthService);
  std::vector<std::unique_ptr<Wt::Auth::OAuthService>> myOAuthServices;

}

void Session::configureAuth()
{
  myAuthService.setAuthTokensEnabled(true, "logincookie");
  myAuthService.setEmailVerificationEnabled(true);

  auto verifier = Wt::cpp14::make_unique<Wt::Auth::PasswordVerifier>();
  verifier->addHashFunction(Wt::cpp14::make_unique<Wt::Auth::BCryptHashFunction>(7));
  myPasswordService.setVerifier(std::move(verifier));
  myPasswordService.setAttemptThrottlingEnabled(true);
  myPasswordService.setStrengthValidator
    (Wt::cpp14::make_unique<Wt::Auth::PasswordStrengthValidator>());

  if (Wt::Auth::GoogleService::configured())
    myOAuthServices.push_back(Wt::cpp14::make_unique<Wt::Auth::GoogleService>(myAuthService));

  if (Wt::Auth::FacebookService::configured())
    myOAuthServices.push_back(Wt::cpp14::make_unique<Wt::Auth::FacebookService>(myAuthService));
}

Session::Session(const std::string& sqliteDb)
{
  //auto connection = cpp14::make_unique<Dbo::backend::Sqlite3>(sqliteDb);
  auto connection = Wt::cpp14::make_unique<Wt::Dbo::backend::Postgres>(sqliteDb);

  connection->setProperty("show-queries", "true");

  setConnection(std::move(connection));

  mapClass<User>("auth.user");
  mapClass<AuthInfo>("auth.auth_info");
  mapClass<AuthInfo::AuthIdentityType>("auth.auth_identity");
  mapClass<AuthInfo::AuthTokenType>("auth.auth_token");

  try {
    createTables();
    std::cerr << "Created database." << std::endl;
  } catch (std::exception& e) {
    std::cerr << e.what() << std::endl;
    std::cerr << "Using existing database";
  }

  users_ = Wt::cpp14::make_unique<UserDatabase>(*this);
}

Session::~Session()
{
}

Wt::Auth::AbstractUserDatabase& Session::users()
{
  return *users_;
}

Wt::Dbo::ptr<User> Session::user()
{
  if (login_.loggedIn())
    return user(login_.user());
  else
    return Wt::Dbo::ptr<User>();
}

Wt::Dbo::ptr<User> Session::user(const Wt::Auth::User& authUser)
{
  Wt::Dbo::ptr<AuthInfo> authInfo = users_->find(authUser);

  Wt::Dbo::ptr<User> user = authInfo->user();

  if (!user) {
    user = add(Wt::cpp14::make_unique<User>());
    authInfo.modify()->setUser(user);
  }

  return user;
}

const Wt::Auth::AuthService& Session::auth()
{
  return myAuthService;
}

const Wt::Auth::PasswordService& Session::passwordAuth()
{
  return myPasswordService;
}

const std::vector<const Wt::Auth::OAuthService*> Session::oAuth()
{
  std::vector<const Wt::Auth::OAuthService *> result;
  for (auto &auth : myOAuthServices) {
    result.push_back(auth.get());
  }
  return result;
}
