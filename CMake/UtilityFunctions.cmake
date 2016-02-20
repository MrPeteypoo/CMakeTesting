# Enable ExternalProject CMake module
include(ExternalProject)

# Adds a library to be linked, assuming it can be found with find_package.
function(required_package SEARCH_FOR LIB_NAME)
    find_package(${SEARCH_FOR} REQUIRED)
    add_linker_files(${LIB_NAME})
endfunction()

# Warns the user if a library being linked doesn't exist.
function(required_library LIB_NAME)
    find_library (${LIB_NAME}_lib ${LIB_NAME})
    if (NOT ${LIB_NAME}_lib)
        message("Library ${LIB_NAME} was not found. Compilation may fail.")
    endif()
    add_linker_files(${LIB_NAME})
endfunction()

# Will attempt to download an external dependency if it can not be found. CMAKE_ARGS are set using ${ARGN}.
function(add_external LIB_NAME FOLDER GIT_REPO TAG INCLUDE_DIR LIB_DIR)
    ExternalProject_Add(
        ${LIB_NAME} GIT_REPOSITORY ${GIT_REPO} GIT_TAG ${TAG} TIMEOUT 10
        PREFIX "${CMAKE_CURRENT_BINARY_DIR}/${FOLDER}"
        INSTALL_DIR "${PROJECT_SOURCE_DIR}/${TARGET_LINK}/${FOLDER}"
        CMAKE_ARGS
            -DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}
            -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
            -DCMAKE_C_COMPILER:PATH=${CMAKE_C_COMPILER}
            -DCMAKE_CXX_COMPILER:PATH=${CMAKE_CXX_COMPILER}
            ${ARGN}
    )
    include_directories(SYSTEM "${PROJECT_SOURCE_DIR}/${TARGET_LINK}/${FOLDER}/${INCLUDE_DIR}")
    link_directories("${PROJECT_SOURCE_DIR}/${TARGET_LINK}/${FOLDER}/${LIB_DIR}")
    add_lib_dependency(external_glfw3)
endfunction()

# Adds an external project without an install command. The source and binaries generated are outputted.
function (add_external_install_disabled LIB_NAME FOLDER GIT_REPO TAG INCLUDE_DIR LIB_DIR)
    ExternalProject_Add(
        ${LIB_NAME} GIT_REPOSITORY ${GIT_REPO} GIT_TAG ${TAG} TIMEOUT 10
        PREFIX "${CMAKE_CURRENT_BINARY_DIR}/${FOLDER}"
        SOURCE_DIR "${PROJECT_SOURCE_DIR}/${TARGET_LINK}/${FOLDER}"
        BINARY_DIR "${PROJECT_SOURCE_DIR}/${TARGET_LINK}/${FOLDER}"
        INSTALL_COMMAND ""
        CMAKE_ARGS
            -DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}
            -DCMAKE_C_COMPILER:PATH=${CMAKE_C_COMPILER}
            -DCMAKE_CXX_COMPILER:PATH=${CMAKE_CXX_COMPILER}
            ${ARGN}
    )
    include_directories(SYSTEM "${PROJECT_SOURCE_DIR}/${TARGET_LINK}/${FOLDER}/${INCLUDE_DIR}")
    link_directories("${PROJECT_SOURCE_DIR}/${TARGET_LINK}/${FOLDER}/${LIB_DIR}")
    add_lib_dependency(${LIB_NAME})
endfunction()
