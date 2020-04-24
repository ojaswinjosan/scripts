TIMEOUT /t 2 /nobreak
start BROWSER /new-window URL
TIMEOUT /t 3 /nobreak
echo Starting Zoom
TIMEOUT /t 2 /nobreak
start %~dp0/start-zoom.ahk
