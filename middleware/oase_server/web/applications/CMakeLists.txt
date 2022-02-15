# set applications Sources
set(APPLICATIONS_SRC
    # main application:
    mainapplication.h
    mainapplication.cpp
)

# finde packeges
find_package(Wt REQUIRED Wt HTTP Dbo)

# creat SHARED lib
add_library(applications SHARED ${APPLICATIONS_SRC})

# link libs
target_link_libraries(applications PUBLIC
    # Wt:
    Wt::Wt
    Wt::HTTP
    Wt::Dbo
    Wt::DboPostgres
    Wt::DboSqlite3
    # widgets:
    widgets
    # models:
    models
)

# add include fir to target
target_include_directories(applications PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
