// This may look like C code, but it's really -*- C++ -*-
/*
 * Copyright (C) 2011 Emweb bv, Herent, Belgium.
 *
 * See the LICENSE file for terms of use.
 */
#ifndef AUTH_WIDGET_H_
#define AUTH_WIDGET_H_

#include <Wt/Auth/AuthWidget.h>

#include <Wt/Auth/User.h>
#include <string>

#include <Wt/WAnchor.h>
#include <Wt/WCheckBox.h>
#include <Wt/WContainerWidget.h>
#include <Wt/WDialog.h>
#include <Wt/WEnvironment.h>
#include <Wt/WImage.h>
#include <Wt/WLineEdit.h>
#include <Wt/WLogger.h>
#include <Wt/WMessageBox.h>
#include <Wt/WPushButton.h>
#include <Wt/WText.h>
#include <Wt/WTheme.h>
#include <Wt/WImage.h>
#include <Wt/WLink.h>
#include <Wt/WLabel.h>

#include "containerwidget.h"
#include "mainview.h"

class Session;

class AuthWidget : public Wt::Auth::AuthWidget
{
public:
  AuthWidget(Session& session);
  ~AuthWidget();

  virtual std::unique_ptr<Wt::WWidget> createRegistrationView(const Wt::Auth::Identity& id) override;
  virtual void createLoggedInView() override;

protected:
  virtual void createLoginView() override;


private:
  Session& session_;

  // Widgets:
  MainView *mainViewWidget_;
  void showTex1();
  void showTex2();
};

#endif // AUTH_WIDGET_H_
