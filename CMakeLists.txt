# This has only been tested on 3.3.
cmake_minimum_required(VERSION 3.3 FATAL_ERROR)

# Everyone needs a name.
project("Fire Engine")

# We need to create the required global variables and determine the build target.
include("CMake/VariablesAndOptions.cmake")
include("CMake/DetermineTarget.cmake")
message("${PLATFORM} ${ARCHITECTURE} ${COMPILER}")
# Set the default compiler options for various different project types.
include("CMake/CompilerOptions.cmake")

# Externals are stored in the External folder and headers are located in Include.
include_directories(SYSTEM "External/Include")
include_directories("Include")

# Finally gather the source and linker files.
include("CMake/FindSourceFiles.cmake")
include("CMake/ConfigureLinker.cmake")

# Add it all together and maintain user specified settings.
add_executable(FireEngine ${SOURCEFILES})
target_link_libraries(FireEngine ${LINKERFILES})
install(TARGETS FireEngine DESTINATION "${INSTALLDIRECTORY}/${PLATFORM}${ARCHITECTURE}${CMAKE_BUILD_TYPE}${COMPILER}")
message("${LINKERFILES}")
# Finally prevent future refreshes from modifying user specified settings.
set(FIREENGINE_PREVIOUSLY_CONFIGURED ON CACHE INTERNAL "Fire engine previously configured")
