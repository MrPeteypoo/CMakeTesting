# Start by adding the correct link directory.
set(GENERAL_LINK "External/Lib/${PLATFORM}${ARCHITECTURE}/${ABI}")
set(TARGET_LINK "${GENERAL_LINK}/${CMAKE_BUILD_TYPE}")

link_directories(${GENERAL_LINK})
link_directories(${TARGET_LINK})

message("Searching for libraries in: ${GENERAL_LINK}")
message("Searching for libraries in: ${TARGET_LINK}")

# Attempt to resolve any dependencies first.
add_external_if_necessary(glfw3 GLFW https://github.com/glfw/glfw.git 3.1.2 STATIC)

# All-target libraries go here.
add_lib_dependency(glfw3)
required_package(opengl)

# Target-specific libraries go here.
if ("${PLATFORM}" STREQUAL "Win")
    if ("${COMPILER}" STREQUAL "Clang")
        add_linker_files(libstdc++)
    endif()

    required_library(gdi32)
    required_library(kernel32)
    required_library(user32)
endif()

# Enable testing if desired.
if (ENABLE_TESTING)
    add_external_if_necessary(googletest GoogleTest https://github.com/google/googletest.git release-1.7.0 STATIC)
    add_lib_dependency(googletest)
endif()
