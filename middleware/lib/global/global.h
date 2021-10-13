#ifndef GLOBAL_H
#define GLOBAL_H

#include <QString>

#include "staticfilecontroller.h"

///
/// \brief staticFileController this is an global variable needed for the file suport of the QtWebApp
///
extern stefanfrings::StaticFileController* staticFileController;
extern QString configFile;


#endif // GLOBAL_H
