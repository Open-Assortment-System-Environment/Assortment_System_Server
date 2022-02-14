# set models Sources
set(MODELS_SRC
    # session
    session.h
    session.cpp
    # user:
    user.h
    user.cpp
    userdetailsmodel.h
    userdetailsmodel.cpp
)

# finde packeges
find_package(Wt REQUIRED Wt HTTP Dbo)

# creat SHARED lib
add_library(models SHARED ${MODELS_SRC})

# link libs
target_link_libraries(models PUBLIC
    # Wt:
    Wt::Wt
    Wt::HTTP
    Wt::Dbo
    Wt::DboPostgres
    Wt::DboSqlite3
)

# add include fir to target
target_include_directories(models PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
