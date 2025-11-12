#!/usr/bin/env bash
set -euo pipefail

# CI helper script (Linux / macOS / WSL)
# Steps:
# 1. mkdir build
# 2. cd build
# 3. cmake ..
# 4. cmake --build .
# 5. ctest

echo "[ci.sh] Starting CI script"

BUILD_DIR="build"

echo "[ci.sh] Creating build directory: ${BUILD_DIR}"
mkdir -p "${BUILD_DIR}"
cd "${BUILD_DIR}"

echo "[ci.sh] Configuring project with CMake"
# Configure with a reasonable default build type; users can override via CMAKE_BUILD_TYPE
cmake .. -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE:-Release}

echo "[ci.sh] Building project"
cmake --build . --config ${CMAKE_BUILD_TYPE:-Release}

echo "[ci.sh] Running tests (ctest)"
if command -v ctest >/dev/null 2>&1; then
	ctest --output-on-failure || { echo "[ci.sh] Some tests failed"; exit 1; }
else
	echo "[ci.sh] ctest not found; attempting to run test executable directly"
	if [ -x "./tests/unit_tests" ]; then
		./tests/unit_tests || { echo "[ci.sh] Tests failed (unit_tests)"; exit 1; }
	else
		echo "[ci.sh] No ctest and no ./tests/unit_tests executable found; skipping tests"
	fi
fi

echo "[ci.sh] CI script finished successfully"
