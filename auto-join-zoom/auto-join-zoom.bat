REM Browsers Tested: chrome, firefox, opera
SET BROWSER=
SET URL=

TIMEOUT /t 2 /nobreak
ECHO Starting %BROWSER%
START %BROWSER% /new-window %URL%
TIMEOUT /t 3 /nobreak
echo Starting Zoom
TIMEOUT /t 2 /nobreak
start %~dp0/start-zoom.ahk
