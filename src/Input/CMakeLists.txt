include_directories(/home/reemh/Downloads/json-fortran/)
link_directories(/home/reemh/Downloads/json-fortran/lib)
add_library(Input replace_words.f90 defaults.f90 datafile_object.f90)
target_link_libraries(Input jsonfortran)


