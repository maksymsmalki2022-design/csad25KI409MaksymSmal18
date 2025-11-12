# csad25KI409MaksymSmal18
This repository contains a small C++ project with a `hello` executable and basic math operations.

## Building the project

Preferred (CMake):

```bash
mkdir -p build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
cmake --build . --config Release
```

The `hello` executable will be placed in `build/bin/hello`.

## Running unit tests

There are two ways to create and run the testing executable.

1) Using CMake (recommended)

```bash
# from repository root
mkdir -p build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTING=ON
cmake --build . --config Release
# run tests via ctest (prints output on failure)
ctest --output-on-failure
# or run the test executable directly:
./tests/unit_tests
```

2) Without CMake (quick compile)

If you prefer a quick manual compile of the tests (requires a working g++ and network access is NOT needed):

```bash
# compile tests and implementation into a single executable
g++ -std=c++17 -O2 tests/unit_tests.cpp math_operations.cpp -I. -o build/unit_tests
./build/unit_tests
```

Notes:
- The CMake configuration fetches GoogleTest automatically when `BUILD_TESTING=ON`. This requires network access during configuration.
- The manual compile (option 2) uses the simple test harness already in `tests/unit_tests.cpp` and does not require GoogleTest.

```

