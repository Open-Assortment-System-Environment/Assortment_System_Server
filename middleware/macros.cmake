
macro(find_or_install_package TARGET GITURL)
    find_package(${TARGET} ${ARGN} EXACT QUIET PATHS ${EXT_INSTALL_PREFIX}/lib/cmake/)
    if(${TARGET}_FOUND)
        message("${TARGET} found")
    else()
        message(WARNING "${TARGET} not found")
        ExternalProject_Add(${TARGET}_ext
            BUILD_ALWAYS TRUE
            GIT_REPOSITORY ${GITURL}
            CMAKE_ARGS
                -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
                -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}
                -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
                -DCMAKE_INSTALL_PREFIX:PATH=${EXT_INSTALL_PREFIX}
                -DQT_QMAKE_EXECUTABLE=${QT_QMAKE_EXECUTABLE}#%{Qt:qmakeExecutable}
                -DEXT_INSTALL_PREFIX=${EXT_INSTALL_PREFIX}
        )
    add_dependencies(build_external_projects ${TARGET}_ext)
    #add_dependencies(middleware ${TARGET}_ext)

    endif()
endmacro()
