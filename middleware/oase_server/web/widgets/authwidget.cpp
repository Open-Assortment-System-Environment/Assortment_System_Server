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

std::unique_ptr<Wt::WWidget> AuthWidget::createRegistrationView(const Auth::Identity& id)
{
  auto registrationView = cpp14::make_unique<RegistrationView>(session_, this);
  std::unique_ptr<Auth::RegistrationModel> model = createRegistrationModel();

  if (id.isValid())
    model->registerIdentified(id);

  registrationView->setModel(std::move(model));
  return std::move(registrationView);
}

void AuthWidget::createLoggedInView()
{
    // base setup of the logged in view
    Auth::AuthWidget::createLoggedInView();
    setTemplateText(tr("template.logged-in"));

    // create nav buttons
    WPushButton *navBTex1
      = bindWidget("nav-b-tex1",
           cpp14::make_unique<WPushButton>("Nav Tex 1"));
    navBTex1->clicked().connect(this, &AuthWidget::showTex1);
    WPushButton *navBTex2
      = bindWidget("nav-b-tex2",
           cpp14::make_unique<WPushButton>("Nav Tex 2"));
    navBTex2->clicked().connect(this, &AuthWidget::showTex2);

    // create main view:
    mainViewWidget_ = bindWidget("main-view-widget", cpp14::make_unique<ContainerWidget>());
    initTex1();
    initTex2();
    showTex1();
}

void AuthWidget::hideAll()
{
    tex1_->hide();
    tex2_->hide();
}

void AuthWidget::initTex1()
{
    tex1_ = mainViewWidget_->addWidget(std::make_unique<Wt::WCheckBox>("Tex1"));
    tex1_->hide();
}

void AuthWidget::initTex2()
{
    tex2_ = mainViewWidget_->addWidget(std::make_unique<Wt::WCheckBox>("Tex2"));
    tex2_->hide();
}

void AuthWidget::showTex1()
{
    hideAll();
    tex1_->show();
}

void AuthWidget::showTex2()
{
    hideAll();
    tex2_->show();
}
