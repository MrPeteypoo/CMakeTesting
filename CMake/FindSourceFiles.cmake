function(add_source_files)
    foreach(FILE ${ARGN})
        set(FILE "${CMAKE_CURRENT_SOURCE_DIR}/${FILE}")
        set(SOURCEFILES ${SOURCEFILES} ${FILE} CACHE INTERNAL "Source files")
    endforeach()
endfunction()

add_subdirectory("Include")
add_subdirectory("Source")
