# Utility functions to maintain consistency.
function(set_cxx_flags FLAGS)
    set(CMAKE_CXX_FLAGS ${FLAGS} CACHE STRING "Default flags" FORCE)
endfunction()
function(set_debug_flags FLAGS)
    set(CMAKE_CXX_FLAGS_DEBUG ${FLAGS} CACHE STRING "Default debug flags" FORCE)
endfunction()
function(set_release_flags FLAGS)
    set(CMAKE_CXX_FLAGS_RELEASE ${FLAGS} CACHE STRING "Default release flags" FORCE)
endfunction()

#message("Comp: ${CMAKE_CXX_COMPILER_ID}, Plat: ${CMAKE_SYSTEM_NAME}, MSVC: ${MSVC_VERSION}")
if (NOT FIREENGINE_PREVIOUSLY_CONFIGURED)
    set(CMAKE_BUILD_TYPE "Release" CACHE STRING "Default build type" FORCE)

    #########################################
    # GCC
    #########################################
    if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
        set(CXX_STANDARD "-std=c++14")
        set(CXX_EXTRAS "-static -pedantic -pedantic-errors")
        set(CXX_WARNINGS "-Wall -Wextra")
        set(CXX_DISABLE "")
        set_cxx_flags("${CXX_STANDARD} ${CXX_EXTRAS} ${CXX_WARNINGS} ${CXX_DISABLE}")

    #########################################
    # Clang
    #########################################
    elseif("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
        set(CXX_STANDARD "-std=c++14")
        set(CXX_STATIC "-static")
        set(CXX_EXTRAS "-pedantic -pedantic-errors")
        set(CXX_WARNINGS "-Weverything")
        set(CXX_DISABLE "-Wno-c++98-compat")

        # On Windows we need to dynamically link libstdc++ because of irritating build issues.
        if ("${CMAKE_SYSTEM_NAME}" STREQUAL "Windows")
            set(CXX_STATIC "")
            message("You're using Clang on Windows, libstdc++ will be linked dynamically.")
        endif()

        set_cxx_flags("${CXX_STANDARD} ${CXX_STATIC} ${CXX_EXTRAS} ${CXX_WARNINGS} ${CXX_DISABLE}")
        set_debug_flags("-O0 -g")
        set_release_flags("-O4 -DNDEBUG")

    #########################################
    # MSVC
    #########################################
    elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")
        set_cxx_flags("/DWIN32 /D_WINDOWS /W4 /GR /EHsc")
    endif()

endif()
