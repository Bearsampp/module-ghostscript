@echo off
REM Test script for Gradle build conversion
REM This script tests all Gradle tasks to ensure they work correctly

echo ========================================================================
echo   Bearsampp Module Ghostscript - Gradle Build Test
echo ========================================================================
echo.

REM Test 1: Display build info
echo [TEST 1] Testing 'gradle info' task...
echo ------------------------------------------------------------------------
call gradle info
if %ERRORLEVEL% NEQ 0 (
    echo [FAILED] gradle info task failed
    exit /b 1
)
echo [PASSED] gradle info task
echo.

REM Test 2: List all tasks
echo [TEST 2] Testing 'gradle tasks' task...
echo ------------------------------------------------------------------------
call gradle tasks
if %ERRORLEVEL% NEQ 0 (
    echo [FAILED] gradle tasks task failed
    exit /b 1
)
echo [PASSED] gradle tasks task
echo.

REM Test 3: List available versions
echo [TEST 3] Testing 'gradle listVersions' task...
echo ------------------------------------------------------------------------
call gradle listVersions
if %ERRORLEVEL% NEQ 0 (
    echo [FAILED] gradle listVersions task failed
    exit /b 1
)
echo [PASSED] gradle listVersions task
echo.

REM Test 4: List releases from properties
echo [TEST 4] Testing 'gradle listReleases' task...
echo ------------------------------------------------------------------------
call gradle listReleases
if %ERRORLEVEL% NEQ 0 (
    echo [FAILED] gradle listReleases task failed
    exit /b 1
)
echo [PASSED] gradle listReleases task
echo.

REM Test 5: Verify build environment
echo [TEST 5] Testing 'gradle verify' task...
echo ------------------------------------------------------------------------
call gradle verify
if %ERRORLEVEL% NEQ 0 (
    echo [FAILED] gradle verify task failed
    exit /b 1
)
echo [PASSED] gradle verify task
echo.

REM Test 6: Validate properties
echo [TEST 6] Testing 'gradle validateProperties' task...
echo ------------------------------------------------------------------------
call gradle validateProperties
if %ERRORLEVEL% NEQ 0 (
    echo [FAILED] gradle validateProperties task failed
    exit /b 1
)
echo [PASSED] gradle validateProperties task
echo.

REM Test 7: Clean build
echo [TEST 7] Testing 'gradle clean' task...
echo ------------------------------------------------------------------------
call gradle clean
if %ERRORLEVEL% NEQ 0 (
    echo [FAILED] gradle clean task failed
    exit /b 1
)
echo [PASSED] gradle clean task
echo.

echo ========================================================================
echo   All Tests Passed!
echo ========================================================================
echo.
echo The Gradle build is working correctly.
echo.
echo To build a release, run:
echo   gradle release -PbundleVersion=10.05.1
echo.
echo Or run interactively:
echo   gradle release
echo.

exit /b 0
