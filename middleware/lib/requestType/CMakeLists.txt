# set requestType Sources
set(REQESTTYPE_SRC
    requesttype.h
    requesttype.cpp
)

# finde packeges
find_package(QT NAMES Qt6 COMPONENTS Core REQUIRED)
find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Core REQUIRED)


# creat SHARED lib
add_library(requestType SHARED ${REQESTTYPE_SRC})

# link libs
target_link_libraries(requestType PUBLIC
    Qt${QT_VERSION_MAJOR}::Core
    global_lib
)

# add include fir to target
target_include_directories(requestType PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
