# set requestParser Sources
set(REQUESTPARSERS_SRC
    apijson.h
    apijson.cpp
)

# creat SHARED lib
add_library(requestParsers SHARED ${REQUESTPARSERS_SRC})

# link libs
target_link_libraries(requestParsers PUBLIC
    Qt${QT_VERSION_MAJOR}::Core
    QtWebApp_Httpserver
)

# add include fir to target
target_include_directories(requestParsers PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
