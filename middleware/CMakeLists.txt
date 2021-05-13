cmake_minimum_required(VERSION 3.19)

project(middleware LANGUAGES CXX)

set(EXT_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}/lib/assortment_system/middleware/EXT_INSTALLS/")
add_custom_target(build_external_projects)

include(ExternalProject)
include(macros.cmake)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_SCRIPT_MODE_FILE)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(QT NAMES Qt6 Qt5 COMPONENTS Core Widgets PrintSupport REQUIRED)
find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Core Widgets PrintSupport REQUIRED)

find_or_install_package(LableLibrary /silo0/Projekte/assortment_system/lable-library/ 0.1.5)

add_executable(middleware
  main.cpp
)
target_link_libraries(middleware
    Qt${QT_VERSION_MAJOR}::Core
    Qt${QT_VERSION_MAJOR}::Widgets
    Qt${QT_VERSION_MAJOR}::PrintSupport
    LableLibrary::LableLibrary
)
