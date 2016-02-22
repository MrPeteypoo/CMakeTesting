# Start with the architecture since that is easy.
if (32BIT)
    set_architecture("32")
else()
    set_architecture("64")
endif()

# GCC, Clang and VC15 are supported.
if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
    set_compiler_and_abi("GCC")

elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
    set_compiler_and_abi("Clang")

elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")

    # Force 64-bit mode for Win64 projects.
    string(FIND "${CMAKE_EXE_LINKER_FLAGS}" "/machine:x64" MSVC32BIT)
    if (${MSVC32BIT} EQUAL -1)
        set_architecture("32")
    else()
        set_architecture("64")
    endif()

    if (${MSVC_VERSION} EQUAL 1900)
        set_compiler_and_abi("MSVC15")
    else()
        set_compiler_and_abi("MSVC")
        message("Your version of MSVC may not be supported.")
    endif()

else()
    set_compiler_and_abi("${CMAKE_CXX_COMPILER_ID}")
    message("Your compiler may not be supported.")
endif()

# Windows is supported.
if ("${CMAKE_SYSTEM_NAME}" STREQUAL "Windows")
    set_platform("Win")

    # Both GCC and Clang use the MinGW-w64 libraries instead.
    if ("${COMPILER}" STREQUAL "GCC" OR "${COMPILER}" STREQUAL "Clang")
        set_abi("MinGW-w64")
    endif()

# Mac OS X is supported.
elseif ("${CMAKE_SYSTEM_NAME}" STREQUAL “Darwin”)
    set_platform(“OSX”)

# Linux is supported.
elseif ("${CMAKE_SYSTEM_NAME}" STREQUAL "Linux")
    set_platform("Linux")

# Testing and library creation for other platforms will be required.
else()
    set_platform("${CMAKE_SYSTEM_NAME}")
    message("Your platform may not be supported.")
endif()
