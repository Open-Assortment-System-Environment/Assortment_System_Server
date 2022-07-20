# set CMake version
cmake_minimum_required(VERSION 3.5)

# set projekt version
project(oase_server LANGUAGES CXX)

# set C++ version
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# find pkg's
find_package(Boost COMPONENTS filesystem)
find_package(Wt REQUIRED Wt HTTP)
find_package(PkgConfig)

# add subdirectorys
#add_subdirectory(api/)
add_subdirectory(web/)

# copy css and confi files
file(COPY css/ DESTINATION ${CMAKE_CURRENT_BINARY_DIR}/css/)
file(COPY strings.xml DESTINATION ${CMAKE_CURRENT_BINARY_DIR})
file(COPY templates.xml DESTINATION ${CMAKE_CURRENT_BINARY_DIR})
file(COPY wt_config.xml DESTINATION ${CMAKE_CURRENT_BINARY_DIR})
file(COPY resources/ DESTINATION ${CMAKE_CURRENT_BINARY_DIR}/resources/)

add_custom_target(run
    COMMAND ./oase_server  --docroot . --http-address 0.0.0.0 --http-port 9090
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)

add_executable(oase_server main.cpp)

target_link_libraries(oase_server
    # Wt:
    Wt::Wt
    Wt::HTTP
    # applications:
    applications
    # widgets:
    widgets
)

