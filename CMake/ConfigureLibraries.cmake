# Start by adding the correct link directory.
set(GENERAL_LINK "External/${PLATFORM}${ARCHITECTURE}/${ABI}")

# MSVC supports multiple build types in a single project so we don't look in a ${CMAKE_BUILD_TYPE} folder to avoid confusion.
if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")
    set(TARGET_LINK ${GENERAL_LINK})
else()
    set(TARGET_LINK "${GENERAL_LINK}/${CMAKE_BUILD_TYPE}")
endif()

link_directories(${GENERAL_LINK})
link_directories(${TARGET_LINK})

message("Searching for libraries in: ${GENERAL_LINK}")
message("Searching for libraries in: ${TARGET_LINK}")

# Attempt to resolve any dependencies first.
add_external(external_glfw3 GLFW https://github.com/glfw/glfw.git 3.1.2 "include" "lib"
    -DGLFW_BUILD_EXAMPLES:BOOL=OFF
    -DGLFW_BUILD_DOCS:BOOL=OFF
    -DGLFW_BUILD_TESTS:BOOL=OFF)

# All-target libraries go here.
add_linker_files(glfw3)
required_package(OpenGL OPENGL_LIBRARIES)

# Target-specific libraries go here.
if ("${PLATFORM}" STREQUAL "Win")
    if ("${COMPILER}" STREQUAL "Clang")
        add_linker_files(libstdc++)
    endif()

    required_library(gdi32)
    required_library(kernel32)
    required_library(user32)

elseif ("${PLATFORM}" STREQUAL "OSX")
    required_library(Cocoa)
    required_library(IOKit)
    required_library(CoreVideo)

elseif ("${PLATFORM}" STREQUAL "Linux")
    required_library(dl)
    required_library(pthread)
    required_library(X11)
    required_library(Xcursor)
    required_library(Xinerama)
    required_library(Xrandr)
    required_library(Xxf86vm)
endif()
