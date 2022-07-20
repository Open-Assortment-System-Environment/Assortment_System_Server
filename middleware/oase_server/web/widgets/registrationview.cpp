/*
 * Copyright (C) 2012 Emweb bv, Herent, Belgium.
 *
 * See the LICENSE file for terms of use.
 */
#include "registrationview.h"
#include "userdetailsmodel.h"

#include <Wt/WLineEdit.h>
#include <Wt/WCheckBox.h>

RegistrationView::RegistrationView(Session& session,
                                   Wt::Auth::AuthWidget *authWidget)
  : Wt::Auth::RegistrationWidget(authWidget),
    session_(session)
{
  setTemplateText(tr("template.registration"));
  detailsModel_ = Wt::cpp14::make_unique<UserDetailsModel>(session_);

  updateView(detailsModel_.get());
}

std::unique_ptr<Wt::WWidget> RegistrationView::createFormWidget(Wt::WFormModel::Field field)
{
  if (field == UserDetailsModel::FavouritePetField)
      return Wt::cpp14::make_unique<Wt::WLineEdit>();
  else if(field == UserDetailsModel::Admin)
      return Wt::cpp14::make_unique<Wt::WCheckBox>();
  else
      return Wt::Auth::RegistrationWidget::createFormWidget(field);
}

bool RegistrationView::validate()
{
  bool result = Wt::Auth::RegistrationWidget::validate();

  updateModel(detailsModel_.get());
  if (!detailsModel_->validate())
    result = false;
  updateView(detailsModel_.get());

  return result;
}

void RegistrationView::registerUserDetails(Wt::Auth::User& user)
{
  detailsModel_->save(user);
}
