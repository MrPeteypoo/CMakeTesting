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
    INSTALL_COMMAND ""
    CMAKE_ARGS
        -DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}
        -DCMAKE_C_COMPILER:PATH=${CMAKE_C_COMPILER}
        -DCMAKE_CXX_COMPILER:PATH=${CMAKE_CXX_COMPILER}
)
add_lib_dependency(external_gmock)

include_directories(SYSTEM "${GMOCK_DIR}/include")
include_directories(SYSTEM "${GMOCK_DIR}/gtest/include")

link_directories(${GMOCK_DIR})
link_directories("${GMOCK_DIR}/gtest")
