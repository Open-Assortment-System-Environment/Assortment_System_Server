# set commandThread Sources
set(COMMANDTHREAD_SRC
    commandthread.h
    commandthread.cpp
)

# creat SHARED lib
add_library(commandThread SHARED ${COMMANDTHREAD_SRC})

# link libs
target_link_libraries(commandThread PUBLIC
    Qt${QT_VERSION_MAJOR}::Core
)

# add include fir to target
target_include_directories(commandThread PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
