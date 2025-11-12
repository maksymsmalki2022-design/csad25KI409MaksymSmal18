cmake_minimum_required(VERSION 3.10)

project(hello_world VERSION 1.0 LANGUAGES CXX)

# Use C++17
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Add executable from main.cpp
add_executable(hello main.cpp)

# Recommended compiler warnings
if (CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")
	target_compile_options(hello PRIVATE -Wall -Wextra -Wpedantic)
elseif (MSVC)
	target_compile_options(hello PRIVATE /W4)
endif()

# Place binaries in build/bin by default
set_target_properties(hello PROPERTIES
	RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
)

# Simple install rule (optional)
install(TARGETS hello RUNTIME DESTINATION bin)

# Quick usage note:
# mkdir build && cd build && cmake .. && cmake --build .

