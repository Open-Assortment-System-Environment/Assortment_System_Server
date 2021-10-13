# set requestParser Sources
set(REQUESTMAPPER_SRC
    requestmapper.h
    requestmapper.cpp
)

# creat SHARED lib
add_library(requestMapper SHARED ${REQUESTMAPPER_SRC})

# link libs
target_link_libraries(requestMapper PUBLIC
    Qt${QT_VERSION_MAJOR}::Core
    QtWebApp_Httpserver
    global_lib
    requestParsers
)

# add include fir to target
target_include_directories(requestMapper PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
