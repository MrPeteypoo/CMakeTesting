# Enable ExternalProject CMake module
include(ExternalProject)

# Adds a library to be linked, assuming it can be found with find_package.
function(required_package LIB_NAME)
    find_package(${LIB_NAME} REQUIRED)
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

# Will attempt to download an external dependency if it can not be found.
function(add_external_if_necessary LIB_NAME FOLDER GIT_REPO GIT_TAG LINK_TYPE)
    find_library (${LIB_NAME}_lib ${LIB_NAME})
    if (NOT ${LIB_NAME}_lib)
        ExternalProject_Add(
            ${LIB_NAME} GIT_REPOSITORY ${GIT_REPO} GIT_TAG ${GIT_TAG} TIMEOUT 10
            PREFIX "${CMAKE_CURRENT_BINARY_DIR}/${FOLDER}"
            INSTALL_DIR "${CMAKE_CURRENT_BINARY_DIR}/${TARGET_LINK}"
            CMAKE_ARGS -DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE} -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
        )
    endif()
endfunction()
