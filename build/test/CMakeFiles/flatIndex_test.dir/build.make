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

# Include any dependencies generated for this target.
include test/CMakeFiles/flatIndex_test.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include test/CMakeFiles/flatIndex_test.dir/compiler_depend.make

# Include the progress variables for this target.
include test/CMakeFiles/flatIndex_test.dir/progress.make

# Include the compile flags for this target's objects.
include test/CMakeFiles/flatIndex_test.dir/flags.make

test/CMakeFiles/flatIndex_test.dir/SystemTest/FlatIndexTest.cpp.o: test/CMakeFiles/flatIndex_test.dir/flags.make
test/CMakeFiles/flatIndex_test.dir/SystemTest/FlatIndexTest.cpp.o: /home/tony/projects/CANDY/test/SystemTest/FlatIndexTest.cpp
test/CMakeFiles/flatIndex_test.dir/SystemTest/FlatIndexTest.cpp.o: test/CMakeFiles/flatIndex_test.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/tony/projects/CANDY/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object test/CMakeFiles/flatIndex_test.dir/SystemTest/FlatIndexTest.cpp.o"
	cd /home/tony/projects/CANDY/build/test && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT test/CMakeFiles/flatIndex_test.dir/SystemTest/FlatIndexTest.cpp.o -MF CMakeFiles/flatIndex_test.dir/SystemTest/FlatIndexTest.cpp.o.d -o CMakeFiles/flatIndex_test.dir/SystemTest/FlatIndexTest.cpp.o -c /home/tony/projects/CANDY/test/SystemTest/FlatIndexTest.cpp

test/CMakeFiles/flatIndex_test.dir/SystemTest/FlatIndexTest.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/flatIndex_test.dir/SystemTest/FlatIndexTest.cpp.i"
	cd /home/tony/projects/CANDY/build/test && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/tony/projects/CANDY/test/SystemTest/FlatIndexTest.cpp > CMakeFiles/flatIndex_test.dir/SystemTest/FlatIndexTest.cpp.i

test/CMakeFiles/flatIndex_test.dir/SystemTest/FlatIndexTest.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/flatIndex_test.dir/SystemTest/FlatIndexTest.cpp.s"
	cd /home/tony/projects/CANDY/build/test && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/tony/projects/CANDY/test/SystemTest/FlatIndexTest.cpp -o CMakeFiles/flatIndex_test.dir/SystemTest/FlatIndexTest.cpp.s

# Object files for target flatIndex_test
flatIndex_test_OBJECTS = \
"CMakeFiles/flatIndex_test.dir/SystemTest/FlatIndexTest.cpp.o"

# External object files for target flatIndex_test
flatIndex_test_EXTERNAL_OBJECTS =

test/flatIndex_test: test/CMakeFiles/flatIndex_test.dir/SystemTest/FlatIndexTest.cpp.o
test/flatIndex_test: test/CMakeFiles/flatIndex_test.dir/build.make
test/flatIndex_test: libCANDY.so
test/flatIndex_test: thirdparty/hdf5-1.14.3/bin/libfaiss.so
test/flatIndex_test: /home/tony/.local/lib/python3.10/site-packages/torch/lib/libtorch.so
test/flatIndex_test: /home/tony/.local/lib/python3.10/site-packages/torch/lib/libc10_cuda.so
test/flatIndex_test: /home/tony/.local/lib/python3.10/site-packages/torch/lib/libc10.so
test/flatIndex_test: /usr/local/cuda/lib64/libcufft.so
test/flatIndex_test: /usr/local/cuda/lib64/libcurand.so
test/flatIndex_test: /usr/local/cuda/lib64/libcublas.so
test/flatIndex_test: /usr/lib/x86_64-linux-gnu/libcudnn.so
test/flatIndex_test: /home/tony/.local/lib/python3.10/site-packages/torch/lib/libc10.so
test/flatIndex_test: /usr/local/cuda/lib64/stubs/libcuda.so
test/flatIndex_test: /usr/local/cuda/lib64/libnvrtc.so
test/flatIndex_test: /usr/local/cuda/lib64/libnvToolsExt.so
test/flatIndex_test: /usr/local/cuda/lib64/libcudart.so
test/flatIndex_test: /home/tony/.local/lib/python3.10/site-packages/torch/lib/libc10_cuda.so
test/flatIndex_test: thirdparty/hdf5-1.14.3/bin/libhdf5.a
test/flatIndex_test: /usr/lib/x86_64-linux-gnu/libz.so
test/flatIndex_test: /usr/lib/x86_64-linux-gnu/libz.so
test/flatIndex_test: test/CMakeFiles/flatIndex_test.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/tony/projects/CANDY/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable flatIndex_test"
	cd /home/tony/projects/CANDY/build/test && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/flatIndex_test.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
test/CMakeFiles/flatIndex_test.dir/build: test/flatIndex_test
.PHONY : test/CMakeFiles/flatIndex_test.dir/build

test/CMakeFiles/flatIndex_test.dir/clean:
	cd /home/tony/projects/CANDY/build/test && $(CMAKE_COMMAND) -P CMakeFiles/flatIndex_test.dir/cmake_clean.cmake
.PHONY : test/CMakeFiles/flatIndex_test.dir/clean

test/CMakeFiles/flatIndex_test.dir/depend:
	cd /home/tony/projects/CANDY/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/tony/projects/CANDY /home/tony/projects/CANDY/test /home/tony/projects/CANDY/build /home/tony/projects/CANDY/build/test /home/tony/projects/CANDY/build/test/CMakeFiles/flatIndex_test.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : test/CMakeFiles/flatIndex_test.dir/depend

