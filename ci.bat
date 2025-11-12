@echo off
REM CI helper script for Windows (cmd)
REM Steps:
REM 1. mkdir build
REM 2. cd build
REM 3. cmake ..
REM 4. cmake --build .
REM 5. ctest

echo [ci.bat] Starting CI script

if not exist build (
    mkdir build
)

cd build || exit /b 1

echo [ci.bat] Configuring project with CMake
cmake .. -DCMAKE_BUILD_TYPE=Release

echo [ci.bat] Building project
cmake --build . --config Release

echo [ci.bat] Running tests (ctest)
where ctest >nul 2>&1
if %ERRORLEVEL%==0 (
    ctest --output-on-failure || (
        echo [ci.bat] Some tests failed
        exit /b 1
    )
) else (
    if exist .\tests\unit_tests.exe (
        .\tests\unit_tests.exe || (
            echo [ci.bat] Tests failed (unit_tests.exe)
            exit /b 1
        )
    ) else (
        echo [ci.bat] No ctest and no tests\unit_tests.exe found; skipping tests
    )
)

echo [ci.bat] CI script finished successfully
