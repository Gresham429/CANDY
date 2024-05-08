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
include benchmark/CMakeFiles/tt.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include benchmark/CMakeFiles/tt.dir/compiler_depend.make

# Include the progress variables for this target.
include benchmark/CMakeFiles/tt.dir/progress.make

# Include the compile flags for this target's objects.
include benchmark/CMakeFiles/tt.dir/flags.make

benchmark/CMakeFiles/tt.dir/src/torchTest.cpp.o: benchmark/CMakeFiles/tt.dir/flags.make
benchmark/CMakeFiles/tt.dir/src/torchTest.cpp.o: /home/tony/projects/CANDY/benchmark/src/torchTest.cpp
benchmark/CMakeFiles/tt.dir/src/torchTest.cpp.o: benchmark/CMakeFiles/tt.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/tony/projects/CANDY/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object benchmark/CMakeFiles/tt.dir/src/torchTest.cpp.o"
	cd /home/tony/projects/CANDY/build/benchmark && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT benchmark/CMakeFiles/tt.dir/src/torchTest.cpp.o -MF CMakeFiles/tt.dir/src/torchTest.cpp.o.d -o CMakeFiles/tt.dir/src/torchTest.cpp.o -c /home/tony/projects/CANDY/benchmark/src/torchTest.cpp

benchmark/CMakeFiles/tt.dir/src/torchTest.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/tt.dir/src/torchTest.cpp.i"
	cd /home/tony/projects/CANDY/build/benchmark && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/tony/projects/CANDY/benchmark/src/torchTest.cpp > CMakeFiles/tt.dir/src/torchTest.cpp.i

benchmark/CMakeFiles/tt.dir/src/torchTest.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/tt.dir/src/torchTest.cpp.s"
	cd /home/tony/projects/CANDY/build/benchmark && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/tony/projects/CANDY/benchmark/src/torchTest.cpp -o CMakeFiles/tt.dir/src/torchTest.cpp.s

# Object files for target tt
tt_OBJECTS = \
"CMakeFiles/tt.dir/src/torchTest.cpp.o"

# External object files for target tt
tt_EXTERNAL_OBJECTS =

benchmark/tt: benchmark/CMakeFiles/tt.dir/src/torchTest.cpp.o
benchmark/tt: benchmark/CMakeFiles/tt.dir/build.make
benchmark/tt: libCANDY.so
benchmark/tt: thirdparty/hdf5-1.14.3/bin/libfaiss.so
benchmark/tt: /home/tony/.local/lib/python3.10/site-packages/torch/lib/libtorch.so
benchmark/tt: /home/tony/.local/lib/python3.10/site-packages/torch/lib/libc10_cuda.so
benchmark/tt: /home/tony/.local/lib/python3.10/site-packages/torch/lib/libc10.so
benchmark/tt: /usr/local/cuda/lib64/libcufft.so
benchmark/tt: /usr/local/cuda/lib64/libcurand.so
benchmark/tt: /usr/local/cuda/lib64/libcublas.so
benchmark/tt: /usr/lib/x86_64-linux-gnu/libcudnn.so
benchmark/tt: /home/tony/.local/lib/python3.10/site-packages/torch/lib/libc10.so
benchmark/tt: /usr/local/cuda/lib64/stubs/libcuda.so
benchmark/tt: /usr/local/cuda/lib64/libnvrtc.so
benchmark/tt: /usr/local/cuda/lib64/libnvToolsExt.so
benchmark/tt: /usr/local/cuda/lib64/libcudart.so
benchmark/tt: /home/tony/.local/lib/python3.10/site-packages/torch/lib/libc10_cuda.so
benchmark/tt: thirdparty/hdf5-1.14.3/bin/libhdf5.a
benchmark/tt: /usr/lib/x86_64-linux-gnu/libz.so
benchmark/tt: /usr/lib/x86_64-linux-gnu/libz.so
benchmark/tt: benchmark/CMakeFiles/tt.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/tony/projects/CANDY/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable tt"
	cd /home/tony/projects/CANDY/build/benchmark && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/tt.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
benchmark/CMakeFiles/tt.dir/build: benchmark/tt
.PHONY : benchmark/CMakeFiles/tt.dir/build

benchmark/CMakeFiles/tt.dir/clean:
	cd /home/tony/projects/CANDY/build/benchmark && $(CMAKE_COMMAND) -P CMakeFiles/tt.dir/cmake_clean.cmake
.PHONY : benchmark/CMakeFiles/tt.dir/clean

benchmark/CMakeFiles/tt.dir/depend:
	cd /home/tony/projects/CANDY/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/tony/projects/CANDY /home/tony/projects/CANDY/benchmark /home/tony/projects/CANDY/build /home/tony/projects/CANDY/build/benchmark /home/tony/projects/CANDY/build/benchmark/CMakeFiles/tt.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : benchmark/CMakeFiles/tt.dir/depend

