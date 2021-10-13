# set requestParser Sources
set(GLOBAL_SRC
    global.h
    global.cpp
)

# creat SHARED lib
add_library(global_lib SHARED ${GLOBAL_SRC})

# link libs
target_link_libraries(global_lib PUBLIC
    Qt${QT_VERSION_MAJOR}::Core
    QtWebApp_Httpserver
)

# add include fir to target
target_include_directories(global_lib PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
