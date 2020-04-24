REM Browsers Tested: chrome, firefox, opera, edge
REM Make sure there's no space after the = sign
SET BROWSER=
SET URL=

TIMEOUT /t 2 /nobreak
ECHO Starting %BROWSER%
IF "%BROWSER%"=="edge" (START microsoft-edge:%URL%) ELSE (START %BROWSER% /new-window %URL%)
TIMEOUT /t 2 /nobreak
echo Starting Zoom
TIMEOUT /t 8 /nobreak
start %~dp0/start-zoom.ahk
