/*
 * Copyright (C) 2012 Emweb bv, Herent, Belgium.
 *
 * See the LICENSE file for terms of use.
 */

#include "authwidget.h"
#include "registrationview.h"
#include "session.h"
#include "userdetailsmodel.h"

AuthWidget::AuthWidget(Session& session)
  : Wt::Auth::AuthWidget(Session::auth(), session.users(), session.login()),
    session_(session)
{
}

AuthWidget::~AuthWidget()
{
    delete mainViewWidget_;
}

std::unique_ptr<Wt::WWidget> AuthWidget::createRegistrationView(const Wt::Auth::Identity& id)
{
  auto registrationView = Wt::cpp14::make_unique<RegistrationView>(session_, this);
  std::unique_ptr<Wt::Auth::RegistrationModel> model = createRegistrationModel();

  if (id.isValid())
    model->registerIdentified(id);

  registrationView->setModel(std::move(model));
  return std::move(registrationView);
}

void AuthWidget::createLoggedInView()
{
    // base setup of the logged in view
    Wt::Auth::AuthWidget::createLoggedInView();
    setTemplateText(tr("template.logged-in"));

    // create main view:
    mainViewWidget_ = bindWidget("main-view-widget", Wt::cpp14::make_unique<MainView>());

    // create nav buttons
    Wt::WPushButton *navBTex1
      = bindWidget("nav-b-tex1",
           Wt::cpp14::make_unique<Wt::WPushButton>("Nav Tex 1"));
    navBTex1->clicked().connect(this, &AuthWidget::showTex1);
    Wt::WPushButton *navBTex2
      = bindWidget("nav-b-tex2",
           Wt::cpp14::make_unique<Wt::WPushButton>("Nav Tex 2"));
    navBTex2->clicked().connect(this, &AuthWidget::showTex2);
}

void AuthWidget::createLoginView()
{
    setTemplateText(tr("template.login"));

    createPasswordLoginView();
    createOAuthLoginView();
#ifdef WT_HAS_SAML
    createSamlLoginView();
#endif // WT_HAS_SAML_

    //Wt::Auth::AuthWidget::createLoginView();
}

void AuthWidget::showTex1()
{
    mainViewWidget_->showTex1();
}

void AuthWidget::showTex2()
{
    mainViewWidget_->showTex2();
}
