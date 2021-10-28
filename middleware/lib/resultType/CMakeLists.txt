# set resultType Sources
set(RESULTTYPE_SRC
    resulttype.h
    resulttype.cpp
)

# finde packeges
find_package(QT NAMES Qt6 COMPONENTS Core REQUIRED)
find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Core REQUIRED)


# creat SHARED lib
add_library(resultType SHARED ${RESULTTYPE_SRC})

# link libs
target_link_libraries(resultType PUBLIC
    Qt${QT_VERSION_MAJOR}::Core
    global_lib
)

# add include fir to target
target_include_directories(resultType PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
