# set widgets Sources
set(WIDGETS_SRC
    # Auth:
    authwidget.h
    authwidget.cpp
    registrationview.h
    registrationview.cpp
    # Container:
    containerwidget.h
    containerwidget.cpp
)

# finde packeges
find_package(Wt REQUIRED Wt HTTP Dbo)

# creat SHARED lib
add_library(widgets SHARED ${WIDGETS_SRC})

# link libs
target_link_libraries(widgets PUBLIC
    # Wt:
    Wt::Wt
    Wt::HTTP
    Wt::Dbo
    Wt::DboPostgres
    Wt::DboSqlite3
    # models
    models
)

# add include fir to target
target_include_directories(widgets PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
