# set dbRequest Sources
set(DBREQEST_SRC
    dbrequest.h     # main DBRequest class
    dbrequest.cpp
    dbsearch.h      # DBSearch class, for searching objekts in the DB
    dbsearch.cpp
)

# finde packeges
find_package(PostgreSQL REQUIRED)
find_package(QT NAMES Qt6 COMPONENTS Core Sql REQUIRED)
find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Core Sql REQUIRED)


# creat SHARED lib
add_library(dbRequest SHARED ${DBREQEST_SRC})

# link libs
target_link_libraries(dbRequest PUBLIC
    Qt${QT_VERSION_MAJOR}::Core
    Qt${QT_VERSION_MAJOR}::Sql
    global_lib
    resultType
    requestType
)

# add include fir to target
target_include_directories(dbRequest PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
