cmake_minimum_required(VERSION 3.10)

project(hello_world VERSION 1.0 LANGUAGES CXX)

# Use C++17
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# -- Library for math operations -------------------------------------------------
add_library(math_ops STATIC math_operations.cpp)
target_include_directories(math_ops PUBLIC ${CMAKE_SOURCE_DIR})

# Recommended compiler warnings
if (CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")
	target_compile_options(math_ops PRIVATE -Wall -Wextra -Wpedantic)
elseif (MSVC)
	target_compile_options(math_ops PRIVATE /W4)
endif()

# Add executable from main.cpp and link math_ops
add_executable(hello main.cpp)
target_link_libraries(hello PRIVATE math_ops)

# Recommended compiler warnings for hello (keeps same flags)
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

# -- Tests (GoogleTest) ---------------------------------------------------------
# Option to enable building tests
option(BUILD_TESTING "Build unit tests" ON)

if (BUILD_TESTING)
	include(CTest)
	enable_testing()

	include(FetchContent)
	FetchContent_Declare(
		googletest
		URL https://github.com/google/googletest/archive/refs/heads/main.zip
	)
	# For Windows: prevent overriding the parent project's compiler/linker settings
	set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
	FetchContent_MakeAvailable(googletest)

	# Test target
	add_executable(unit_tests tests/unit_tests.cpp)
	target_link_libraries(unit_tests PRIVATE math_ops GTest::gtest_main)
	target_include_directories(unit_tests PRIVATE ${CMAKE_SOURCE_DIR})

	include(GoogleTest)
	gtest_discover_tests(unit_tests)
endif()

# Quick usage note:
# mkdir build && cd build && cmake .. && cmake --build .

