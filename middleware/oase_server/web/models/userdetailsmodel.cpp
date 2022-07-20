/*
 * Copyright (C) 2012 Emweb bv, Herent, Belgium.
 *
 * See the LICENSE file for terms of use.
 */

#include "userdetailsmodel.h"
#include "user.h"
#include "session.h"


const Wt::WFormModel::Field
UserDetailsModel::FavouritePetField = "favourite-pet";
const Wt::WFormModel::Field
UserDetailsModel::Admin = "admin";

UserDetailsModel::UserDetailsModel(Session& session)
  : WFormModel(),
    session_(session)
{
  addField(FavouritePetField, Wt::WString::tr("favourite-pet-info"));
  addField(Admin, Wt::WString::tr("admin-info"));
}

void UserDetailsModel::save(const Wt::Auth::User& authUser)
{
  Wt::Dbo::ptr<User> user = session_.user(authUser);
  user.modify()->favouritePet = valueText(FavouritePetField).toUTF8();
  Wt::log("notice") << "(regSave Admin: " << valueText(Admin) << ")";
  bool tmpValue = false;
  if(valueText(Admin) == "true")
      tmpValue = true;
  user.modify()->admin = tmpValue;
}
