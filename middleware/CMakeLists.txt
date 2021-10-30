cmake_minimum_required(VERSION 3.21)

# set project
project(middleware LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_SCRIPT_MODE_FILE)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

# set config variables
set(CONFIG_DIR "/etc/as_middleware/" CACHE STRING "Sets the folder for the config files, for developments use other dir")
set(PROGRMA_DATA "/etc/as_middleware/data/" CACHE STRING "Sets the folder where data from the server are stored, such as datasheets")

# add install for Config dir
install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/etc/ DESTINATION ${CONFIG_DIR})

# configure files
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/global_main.in.h ${CMAKE_BINARY_DIR}/global_main.h)

# set C++ settings
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# find packages
find_package(QT NAMES Qt6 Qt5 COMPONENTS Core Widgets REQUIRED)
find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Core Widgets REQUIRED)

message(STATUS Qt${QT_VERSION_MAJOR})
message(STATUS ${CMAKE_PREFIX_PATH})

# add subdirectorys
add_subdirectory(QtWebApp/)
add_subdirectory(lib/)
add_subdirectory(doc/)

# creat sorce variables
set(MAIN_SOURCE
    ${CMAKE_BINARY_DIR}/global_main.h
    ${CMAKE_CURRENT_SOURCE_DIR}/main.cpp
)

# creat executable
add_executable(middleware
  ${MAIN_SOURCE}
)
target_link_libraries(middleware
    Qt${QT_VERSION_MAJOR}::Core
    Qt${QT_VERSION_MAJOR}::Widgets
    QtWebApp_Httpserver
    QtWebApp_Logging
    QtWebApp_Templateengine
    global_lib
    commandThread
    requestMapper
)

message(STATUS ${CMAKE_C_COMPILER})
message(STATUS ${CMAKE_CXX_COMPILER})
