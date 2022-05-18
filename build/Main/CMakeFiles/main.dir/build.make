# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.15

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /opt/sw/openhpc/pub/utils/cmake/3.15.4/bin/cmake

# The command to remove a file.
RM = /opt/sw/openhpc/pub/utils/cmake/3.15.4/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/reemh/eclipse-workspace/Backus_test/src

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/reemh/eclipse-workspace/Backus_test/build

# Include any dependencies generated for this target.
include Main/CMakeFiles/main.dir/depend.make

# Include the progress variables for this target.
include Main/CMakeFiles/main.dir/progress.make

# Include the compile flags for this target's objects.
include Main/CMakeFiles/main.dir/flags.make

Main/CMakeFiles/main.dir/main.f90.o: Main/CMakeFiles/main.dir/flags.make
Main/CMakeFiles/main.dir/main.f90.o: /home/reemh/eclipse-workspace/Backus_test/src/Main/main.f90
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/reemh/eclipse-workspace/Backus_test/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building Fortran object Main/CMakeFiles/main.dir/main.f90.o"
	cd /home/reemh/eclipse-workspace/Backus_test/build/Main && /opt/sw/intel18/compilers_and_libraries_2018.1.163/linux/mpi/intel64/bin/mpiifort $(Fortran_DEFINES) $(Fortran_INCLUDES) $(Fortran_FLAGS) -c /home/reemh/eclipse-workspace/Backus_test/src/Main/main.f90 -o CMakeFiles/main.dir/main.f90.o

Main/CMakeFiles/main.dir/main.f90.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing Fortran source to CMakeFiles/main.dir/main.f90.i"
	cd /home/reemh/eclipse-workspace/Backus_test/build/Main && /opt/sw/intel18/compilers_and_libraries_2018.1.163/linux/mpi/intel64/bin/mpiifort $(Fortran_DEFINES) $(Fortran_INCLUDES) $(Fortran_FLAGS) -E /home/reemh/eclipse-workspace/Backus_test/src/Main/main.f90 > CMakeFiles/main.dir/main.f90.i

Main/CMakeFiles/main.dir/main.f90.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling Fortran source to assembly CMakeFiles/main.dir/main.f90.s"
	cd /home/reemh/eclipse-workspace/Backus_test/build/Main && /opt/sw/intel18/compilers_and_libraries_2018.1.163/linux/mpi/intel64/bin/mpiifort $(Fortran_DEFINES) $(Fortran_INCLUDES) $(Fortran_FLAGS) -S /home/reemh/eclipse-workspace/Backus_test/src/Main/main.f90 -o CMakeFiles/main.dir/main.f90.s

# Object files for target main
main_OBJECTS = \
"CMakeFiles/main.dir/main.f90.o"

# External object files for target main
main_EXTERNAL_OBJECTS =

/home/reemh/eclipse-workspace/Backus_test/src/exec/main: Main/CMakeFiles/main.dir/main.f90.o
/home/reemh/eclipse-workspace/Backus_test/src/exec/main: Main/CMakeFiles/main.dir/build.make
/home/reemh/eclipse-workspace/Backus_test/src/exec/main: archive/libMain.a
/home/reemh/eclipse-workspace/Backus_test/src/exec/main: archive/libMesh.a
/home/reemh/eclipse-workspace/Backus_test/src/exec/main: archive/libTime_step.a
/home/reemh/eclipse-workspace/Backus_test/src/exec/main: archive/libRezone_and_Advect.a
/home/reemh/eclipse-workspace/Backus_test/src/exec/main: archive/libInput.a
/home/reemh/eclipse-workspace/Backus_test/src/exec/main: lib/libParallel.so
/home/reemh/eclipse-workspace/Backus_test/src/exec/main: lib/libGeneral.so
/home/reemh/eclipse-workspace/Backus_test/src/exec/main: archive/libBC.a
/home/reemh/eclipse-workspace/Backus_test/src/exec/main: archive/libQuantities.a
/home/reemh/eclipse-workspace/Backus_test/src/exec/main: archive/libBC_Cell.a
/home/reemh/eclipse-workspace/Backus_test/src/exec/main: archive/libBC_Vertex.a
/home/reemh/eclipse-workspace/Backus_test/src/exec/main: archive/libQ_Vertex.a
/home/reemh/eclipse-workspace/Backus_test/src/exec/main: archive/libQ_Cell.a
/home/reemh/eclipse-workspace/Backus_test/src/exec/main: archive/libMaterial.a
/home/reemh/eclipse-workspace/Backus_test/src/exec/main: archive/libEOS.a
/home/reemh/eclipse-workspace/Backus_test/src/exec/main: lib/libDiagnostics.so
/home/reemh/eclipse-workspace/Backus_test/src/exec/main: lib/libSilo.so
/home/reemh/eclipse-workspace/Backus_test/src/exec/main: Main/CMakeFiles/main.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/reemh/eclipse-workspace/Backus_test/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking Fortran executable /home/reemh/eclipse-workspace/Backus_test/src/exec/main"
	cd /home/reemh/eclipse-workspace/Backus_test/build/Main && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/main.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
Main/CMakeFiles/main.dir/build: /home/reemh/eclipse-workspace/Backus_test/src/exec/main

.PHONY : Main/CMakeFiles/main.dir/build

Main/CMakeFiles/main.dir/clean:
	cd /home/reemh/eclipse-workspace/Backus_test/build/Main && $(CMAKE_COMMAND) -P CMakeFiles/main.dir/cmake_clean.cmake
.PHONY : Main/CMakeFiles/main.dir/clean

Main/CMakeFiles/main.dir/depend:
	cd /home/reemh/eclipse-workspace/Backus_test/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/reemh/eclipse-workspace/Backus_test/src /home/reemh/eclipse-workspace/Backus_test/src/Main /home/reemh/eclipse-workspace/Backus_test/build /home/reemh/eclipse-workspace/Backus_test/build/Main /home/reemh/eclipse-workspace/Backus_test/build/Main/CMakeFiles/main.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : Main/CMakeFiles/main.dir/depend

