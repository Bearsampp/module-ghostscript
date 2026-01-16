@ECHO OFF

cd %~dp0
bin\gswin64c.exe -q -dBATCH -sFONTDIR=c:/windows/fonts -sCIDFMAP=lib/cidfmap lib/mkcidfm.ps
