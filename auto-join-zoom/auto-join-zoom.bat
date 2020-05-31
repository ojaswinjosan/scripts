@echo off
REM Browsers Tested: chrome, firefox, opera, edge
REM Make sure there's no space after the = sign
SET BROWSER=edge
SET URL=
SET AHK-LOCATION="C:\Program Files\AutoHotkey\AutoHotkey.exe"

TIMEOUT /t 2 /nobreak > NUL
ECHO Starting %BROWSER%
IF "%BROWSER%"=="edge" (START microsoft-edge:%URL%) ELSE (START %BROWSER% /new-window %URL%)
TIMEOUT /t 2 /nobreak > NUL
echo Starting Zoom
TIMEOUT /t 8 /nobreak > NUL
%AHK-LOCATION% "%~dp0\start-zoom.ahk"
