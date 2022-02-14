/*
 * Copyright (C) 2012 Emweb bv, Herent, Belgium.
 *
 * See the LICENSE file for terms of use.
 */

#include "userdetailsmodel.h"
#include "user.h"
#include "session.h"


const WFormModel::Field
UserDetailsModel::FavouritePetField = "favourite-pet";
const WFormModel::Field
UserDetailsModel::Admin = "admin";

UserDetailsModel::UserDetailsModel(Session& session)
  : WFormModel(),
    session_(session)
{
  addField(FavouritePetField, WString::tr("favourite-pet-info"));
  addField(Admin, WString::tr("admin-info"));
}

void UserDetailsModel::save(const Auth::User& authUser)
{
  Dbo::ptr<User> user = session_.user(authUser);
  user.modify()->favouritePet = valueText(FavouritePetField).toUTF8();
  log("notice") << "(regSave Admin: " << valueText(Admin) << ")";
  bool tmpValue = false;
  if(valueText(Admin) == "true")
      tmpValue = true;
  user.modify()->admin = tmpValue;
}
