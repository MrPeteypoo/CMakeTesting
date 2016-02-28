#add_external_install_disabled(external_gtest "GoogleMock/gtest" https://github.com/google/googletest.git release-1.7.0 "include" "")
#add_external_install_disabled(external_gmock "GoogleMock" https://github.com/google/googlemock.git release-1.7.0 "include" "")

# Unfortunately we can't obtain GoogleMock from GitHub because it won't build on MinGW. There's also the problem of the
# 1.7.0 tag not including gtest which causes a compilation failure. Instead, download 1.7.0 in zip format. It's unfortuante
# and messy but for now there isn't much of a choice.
set(GMOCK_DIR "${PROJECT_SOURCE_DIR}/${TARGET_LINK}/GoogleMock" CACHE INTERNAL "Gmock Dir")
ExternalProject_Add(external_gmock URL https://googlemock.googlecode.com/files/gmock-1.7.0.zip TIMEOUT 10
    PREFIX "${CMAKE_CURRENT_BINARY_DIR}/GoogleMock"
    SOURCE_DIR ${GMOCK_DIR}
    BINARY_DIR ${GMOCK_DIR}
    DOWNLOAD_NO_PROGRESS 1
    INSTALL_COMMAND ""
    CMAKE_ARGS
        -DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}
        -DCMAKE_C_COMPILER:PATH=${CMAKE_C_COMPILER}
        -DCMAKE_CXX_COMPILER:PATH=${CMAKE_CXX_COMPILER}
        -DCMAKE_CXX_FLAGS:STRING=${STDLIB}
)

# Ensure the Google mocking framework is built first before the engine.
add_lib_dependency(external_gmock)

link_directories("${GMOCK_DIR}")
link_directories("${GMOCK_DIR}/gtest")

set(CURR_DIR ${CMAKE_CURRENT_SOURCE_DIR})

function(create_test TEST_NAME)
    # Create a target for the test.
    add_executable(${TEST_NAME} ${ARGN})

    # Include necessary directories.
    target_include_directories(${TEST_NAME} SYSTEM PUBLIC "${GMOCK_DIR}/include")
    target_include_directories(${TEST_NAME} SYSTEM PUBLIC "${GMOCK_DIR}/gtest/include")
    target_include_directories(${TEST_NAME} PUBLIC "${CURR_DIR}")

    # Testing libraries must be linked first.
    target_link_libraries(${TEST_NAME} gtest_main gmock_main)

    # Turn off annoying warnings which occur due to the testing framework.
    if ("${COMPILER}" STREQUAL "GCC" OR "${COMPILER}" STREQUAL "Clang")
        target_compile_options(${TEST_NAME} PUBLIC -Wno-global-constructors)
        target_link_libraries(${TEST_NAME} pthread)
    endif()

    # Add dependencies of the engine.
    target_link_libraries(${TEST_NAME} ${LINKER_FILES})

    # Finally we're ready to add the test!
    add_test(${TEST_NAME} ${TEST_NAME})
endfunction()

# Finally start creating tests!
add_subdirectory("FireEngine")
