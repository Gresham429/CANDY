# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.25

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /home/tony/.local/lib/python3.10/site-packages/cmake/data/bin/cmake

# The command to remove a file.
RM = /home/tony/.local/lib/python3.10/site-packages/cmake/data/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/tony/projects/CANDY

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/tony/projects/CANDY/build

# Utility rule file for ExperimentalTest.

# Include any custom commands dependencies for this target.
include thirdparty/faiss/CMakeFiles/ExperimentalTest.dir/compiler_depend.make

# Include the progress variables for this target.
include thirdparty/faiss/CMakeFiles/ExperimentalTest.dir/progress.make

thirdparty/faiss/CMakeFiles/ExperimentalTest:
	cd /home/tony/projects/CANDY/build/thirdparty/faiss && /home/tony/.local/lib/python3.10/site-packages/cmake/data/bin/ctest -D ExperimentalTest

ExperimentalTest: thirdparty/faiss/CMakeFiles/ExperimentalTest
ExperimentalTest: thirdparty/faiss/CMakeFiles/ExperimentalTest.dir/build.make
.PHONY : ExperimentalTest

# Rule to build all files generated by this target.
thirdparty/faiss/CMakeFiles/ExperimentalTest.dir/build: ExperimentalTest
.PHONY : thirdparty/faiss/CMakeFiles/ExperimentalTest.dir/build

thirdparty/faiss/CMakeFiles/ExperimentalTest.dir/clean:
	cd /home/tony/projects/CANDY/build/thirdparty/faiss && $(CMAKE_COMMAND) -P CMakeFiles/ExperimentalTest.dir/cmake_clean.cmake
.PHONY : thirdparty/faiss/CMakeFiles/ExperimentalTest.dir/clean

thirdparty/faiss/CMakeFiles/ExperimentalTest.dir/depend:
	cd /home/tony/projects/CANDY/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/tony/projects/CANDY /home/tony/projects/CANDY/thirdparty/faiss /home/tony/projects/CANDY/build /home/tony/projects/CANDY/build/thirdparty/faiss /home/tony/projects/CANDY/build/thirdparty/faiss/CMakeFiles/ExperimentalTest.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : thirdparty/faiss/CMakeFiles/ExperimentalTest.dir/depend

