# Start by adding the correct link directory.
set(LINKDIRECTORY "External/Lib/${PLATFORM}${ARCHITECTURE}/${ABI}")
link_directories(${LINKDIRECTORY})
message("Libraries search directory is: ${LINKDIRECTORY}")

# All-target libraries go here.
add_linker_files(opengl32 glfw3)

# Target-specific libraries go here.
if ("${PLATFORM}" STREQUAL "Win" AND "${COMPILER}" STREQUAL "Clang")
    add_linker_files(libstdc++)
endif()
