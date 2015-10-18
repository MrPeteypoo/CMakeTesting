# This has only been tested on 3.2.
cmake_minimum_required(VERSION 3.3 FATAL_ERROR)

# Everyone needs a name.
project("Fire Engine")

# We'll need a global variable to store all the headers and source files and a function to add to it.
set(SOURCE "" CACHE INTERNAL "Source")
function(add_source_files)
    foreach(FILE ${ARGN})
        set(FILE "${CMAKE_CURRENT_SOURCE_DIR}/${FILE}")
        set(SOURCE ${SOURCE} ${FILE} CACHE INTERNAL "Source")
    endforeach()
endfunction()

# Externals are stored in the External folder, headers are located in Include and source files are in Source.
include_directories(SYSTEM "External/Include")
include_directories("Include")
add_subdirectory("Include")
add_subdirectory("Source")
link_directories("External/Lib/Win64/MinGW")
link_directories("External/Lib/Win64/VC15")

# Add it all together.
add_executable(FireEngine ${SOURCE})
target_link_libraries(FireEngine opengl32)
target_link_libraries(FireEngine glfw3)

# Set default compiler options.
if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang" OR
    "${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
    set(CXX_STANDARD "-std=c++14")
    set(CXX_EXTRAS "-pedantic -pedantic-errors")
    set(CXX_WARNINGS "-Weverything")
    set(CXX_DISABLE "-Wno-c++98-compat")
    set(CXX_PREDEFINED_MACROS "")
    set(CMAKE_CXX_FLAGS "${CXX_STANDARD} ${CXX_EXTRAS} ${CXX_WARNINGS} ${CXX_DISABLE} ${CXX_PREDEFINED_MACROS}"
        CACHE STRING "Default flags" FORCE)
    target_link_libraries(FireEngine libstdc++)
endif()
