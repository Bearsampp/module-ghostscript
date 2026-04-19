@ECHO OFF

pushd "%~dp0"
if not exist "%~dp0bin\gswin64c.exe" (
    echo ERROR: gswin64c.exe not found in "%~dp0bin"
    exit /b 1
)
"%~dp0bin\gswin64c.exe" -q -dBATCH -sFONTDIR=c:/windows/fonts -sCIDFMAP=lib/cidfmap lib/mkcidfm.ps
set EXITCODE=%ERRORLEVEL%
popd
exit /b %EXITCODE%
