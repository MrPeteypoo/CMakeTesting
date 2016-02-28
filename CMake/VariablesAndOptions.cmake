# We need variables for determining the current target.
set(PLATFORM "" CACHE INTERNAL "Platform")
set(ARCHITECTURE "" CACHE INTERNAL "Architecture")
set(COMPILER "" CACHE INTERNAL "Compiler")
set(ABI "" CACHE INTERNAL "ABI")

# We shall also store all source and linked files in variables.
set(SOURCE_FILES "" CACHE INTERNAL "Source files")
set(LINKER_FILES "" CACHE INTERNAL "Linker files")
set(DEPENDENCIES "" CACHE INTERNAL "Dependencies")

# User specifiable options.
option(32BIT "Is the target a 32-bit architecture? This determines what libraries to link against." OFF)
option(ENABLE_TESTING "Enable unit testing of the engine?" OFF)
set(INSTALL_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/Compiled" CACHE PATH "Where should compiled executables be placed?")

# Utility functions.
function(set_platform OS)
    set(PLATFORM ${OS} CACHE INTERNAL "Platform")
endfunction()

function(set_architecture BUSWIDTH)
    set(ARCHITECTURE ${BUSWIDTH} CACHE INTERNAL "Architecture")
endfunction()

function(set_compiler TOOL)
    set(COMPILER ${TOOL} CACHE INTERNAL "Compiler")
endfunction()

function(set_abi COMPILERABI)
    set(ABI ${COMPILERABI} CACHE INTERNAL "ABI")
endfunction()

function(set_compiler_and_abi TOOL)
    set(COMPILER ${TOOL} CACHE INTERNAL "Compiler")
    set(ABI ${TOOL} CACHE INTERNAL "ABI")
endfunction()

function(add_source_files)
    foreach(FILE ${ARGN})
        set(FILE "${CMAKE_CURRENT_SOURCE_DIR}/${FILE}")
        set(SOURCE_FILES ${SOURCE_FILES} ${FILE} CACHE INTERNAL "Source files")
    endforeach()
endfunction()

function(add_linker_files)
    foreach(LIBRARY ${ARGN})
        set(LINKER_FILES ${LINKER_FILES} ${LIBRARY} CACHE INTERNAL "Linker files")
    endforeach()
endfunction()

function(add_lib_dependency)
    foreach(DEPENDENCY ${ARGN})
        set(DEPENDENCIES ${DEPENDENCIES} ${DEPENDENCY} CACHE INTERNAL "Dependencies")
    endforeach()
endfunction()
