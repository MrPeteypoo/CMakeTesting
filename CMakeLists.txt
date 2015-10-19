# This has only been tested on 3.3.
cmake_minimum_required(VERSION 3.3 FATAL_ERROR)

# Everyone needs a name.
project("Fire Engine")

# Set the default compiler options for various different project types.
include("CMake/CompilerOptions.cmake")

# Externals are stored in the External folder and headers are located in Include.
include_directories(SYSTEM "External/Include")
include_directories("Include")

# The SOURCEFILES global is filled by the FindSourceFiles.cmake file.
set(SOURCEFILES "" CACHE INTERNAL "Source files")
include("CMake/FindSourceFiles.cmake")

# We'll need to generate a list of libraries to be included based on the target.
set(LINKERFILES "")
include("CMake/ConfigureLinker.cmake")

# Add it all together and maintain user specified settings.
add_executable(FireEngine ${SOURCEFILES})
target_link_libraries(FireEngine ${LINKERFILES})
target_link_libraries(FireEngine opengl32 glfw3)
set(FIREENGINE_PREVIOUSLY_CONFIGURED ON CACHE INTERNAL "Fire engine previously configured")
