
if(NOT "/silo0/GitHubDesktop/Assortment_System_Server/build-middleware-Desktop_Qt_6_2_0_GCC_64bit-Debug/LabelLibrary_ext-prefix/src/LabelLibrary_ext-stamp/LabelLibrary_ext-gitinfo.txt" IS_NEWER_THAN "/silo0/GitHubDesktop/Assortment_System_Server/build-middleware-Desktop_Qt_6_2_0_GCC_64bit-Debug/LabelLibrary_ext-prefix/src/LabelLibrary_ext-stamp/LabelLibrary_ext-gitclone-lastrun.txt")
  message(STATUS "Avoiding repeated git clone, stamp file is up to date: '/silo0/GitHubDesktop/Assortment_System_Server/build-middleware-Desktop_Qt_6_2_0_GCC_64bit-Debug/LabelLibrary_ext-prefix/src/LabelLibrary_ext-stamp/LabelLibrary_ext-gitclone-lastrun.txt'")
  return()
endif()

execute_process(
  COMMAND ${CMAKE_COMMAND} -E rm -rf "/silo0/GitHubDesktop/Assortment_System_Server/build-middleware-Desktop_Qt_6_2_0_GCC_64bit-Debug/LabelLibrary_ext-prefix/src/LabelLibrary_ext"
  RESULT_VARIABLE error_code
  )
if(error_code)
  message(FATAL_ERROR "Failed to remove directory: '/silo0/GitHubDesktop/Assortment_System_Server/build-middleware-Desktop_Qt_6_2_0_GCC_64bit-Debug/LabelLibrary_ext-prefix/src/LabelLibrary_ext'")
endif()

# try the clone 3 times in case there is an odd git clone issue
set(error_code 1)
set(number_of_tries 0)
while(error_code AND number_of_tries LESS 3)
  execute_process(
    COMMAND "/usr/bin/git"  clone --no-checkout --config "advice.detachedHead=false" "/silo0/Projekte/assortment_system/label-library/" "LabelLibrary_ext"
    WORKING_DIRECTORY "/silo0/GitHubDesktop/Assortment_System_Server/build-middleware-Desktop_Qt_6_2_0_GCC_64bit-Debug/LabelLibrary_ext-prefix/src"
    RESULT_VARIABLE error_code
    )
  math(EXPR number_of_tries "${number_of_tries} + 1")
endwhile()
if(number_of_tries GREATER 1)
  message(STATUS "Had to git clone more than once:
          ${number_of_tries} times.")
endif()
if(error_code)
  message(FATAL_ERROR "Failed to clone repository: '/silo0/Projekte/assortment_system/label-library/'")
endif()

execute_process(
  COMMAND "/usr/bin/git"  checkout master --
  WORKING_DIRECTORY "/silo0/GitHubDesktop/Assortment_System_Server/build-middleware-Desktop_Qt_6_2_0_GCC_64bit-Debug/LabelLibrary_ext-prefix/src/LabelLibrary_ext"
  RESULT_VARIABLE error_code
  )
if(error_code)
  message(FATAL_ERROR "Failed to checkout tag: 'master'")
endif()

set(init_submodules TRUE)
if(init_submodules)
  execute_process(
    COMMAND "/usr/bin/git"  submodule update --recursive --init 
    WORKING_DIRECTORY "/silo0/GitHubDesktop/Assortment_System_Server/build-middleware-Desktop_Qt_6_2_0_GCC_64bit-Debug/LabelLibrary_ext-prefix/src/LabelLibrary_ext"
    RESULT_VARIABLE error_code
    )
endif()
if(error_code)
  message(FATAL_ERROR "Failed to update submodules in: '/silo0/GitHubDesktop/Assortment_System_Server/build-middleware-Desktop_Qt_6_2_0_GCC_64bit-Debug/LabelLibrary_ext-prefix/src/LabelLibrary_ext'")
endif()

# Complete success, update the script-last-run stamp file:
#
execute_process(
  COMMAND ${CMAKE_COMMAND} -E copy
    "/silo0/GitHubDesktop/Assortment_System_Server/build-middleware-Desktop_Qt_6_2_0_GCC_64bit-Debug/LabelLibrary_ext-prefix/src/LabelLibrary_ext-stamp/LabelLibrary_ext-gitinfo.txt"
    "/silo0/GitHubDesktop/Assortment_System_Server/build-middleware-Desktop_Qt_6_2_0_GCC_64bit-Debug/LabelLibrary_ext-prefix/src/LabelLibrary_ext-stamp/LabelLibrary_ext-gitclone-lastrun.txt"
  RESULT_VARIABLE error_code
  )
if(error_code)
  message(FATAL_ERROR "Failed to copy script-last-run stamp file: '/silo0/GitHubDesktop/Assortment_System_Server/build-middleware-Desktop_Qt_6_2_0_GCC_64bit-Debug/LabelLibrary_ext-prefix/src/LabelLibrary_ext-stamp/LabelLibrary_ext-gitclone-lastrun.txt'")
endif()

