# We need variables for determining the current target.
set(PLATFORM "" CACHE INTERNAL "Platform")
set(ARCHITECTURE "" CACHE INTERNAL "Architecture")
set(COMPILER "" CACHE INTERNAL "Compiler")
set(ABI "" CACHE INTERNAL "ABI")

# We shall also store all source and linked files in variables.
set(SOURCEFILES "" CACHE INTERNAL "Source files")
set(LINKERFILES "" CACHE INTERNAL "Linker files")

# User specifiable options.
option(32BIT "Is the target a 32-bit architecture? This has no effect with MSVC." OFF)
set(INSTALLDIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/Compiled" CACHE PATH "Where should compiled executables be placed?")

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
        set(SOURCEFILES ${SOURCEFILES} ${FILE} CACHE INTERNAL "Source files")
    endforeach()
endfunction()

function(add_linker_files)
    foreach(LIBRARY ${ARGN})
        set(LINKERFILES ${LINKERFILES} ${LIBRARY} CACHE INTERNAL "Linker files")
    endforeach()
endfunction()
