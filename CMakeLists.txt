# This has only been tested on 3.3.
cmake_minimum_required(VERSION 3.3 FATAL_ERROR)

# Everyone needs a name.
project("Fire Engine")

# We need to create the required global variables and determine the build target.
include("CMake/VariablesAndOptions.cmake")
include("CMake/UtilityFunctions.cmake")
include("CMake/DetermineTarget.cmake")

# Set the default compiler options for various different project types.
include("CMake/CompilerOptions.cmake")

# Headers are located in Include.
include_directories(SYSTEM "External/Include")
include_directories("Include")

# Finally gather the source and linker files.
include("CMake/FindSourceFiles.cmake")
include("CMake/ConfigureLibraries.cmake")

# Enable testing if specified.
if (ENABLE_TESTING)
    enable_testing()
    include_directories("Testing")
    add_subdirectory("Testing")
endif()

# Add it all together and maintain user specified settings.
add_executable(FireEngine ${SOURCE_FILES})
add_dependencies(FireEngine ${DEPENDENCIES})
target_link_libraries(FireEngine ${LINKER_FILES})
install(TARGETS FireEngine DESTINATION "${INSTALL_DIRECTORY}/${PLATFORM}${ARCHITECTURE}${COMPILER}Debug" CONFIGURATIONS Debug)
install(TARGETS FireEngine DESTINATION "${INSTALL_DIRECTORY}/${PLATFORM}${ARCHITECTURE}${COMPILER}MinSizeRel" CONFIGURATIONS MinSizeRel)
install(TARGETS FireEngine DESTINATION "${INSTALL_DIRECTORY}/${PLATFORM}${ARCHITECTURE}${COMPILER}Release" CONFIGURATIONS Release)
install(TARGETS FireEngine DESTINATION "${INSTALL_DIRECTORY}/${PLATFORM}${ARCHITECTURE}${COMPILER}RelWithDebInfo" CONFIGURATIONS RelWithDebInfo)

# Finally prevent future refreshes from modifying user specified settings.
set(FIREENGINE_PREVIOUSLY_CONFIGURED ON CACHE INTERNAL "Fire engine previously configured")
