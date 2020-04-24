TIMEOUT /t 2
start BROWSER /new-window URL
TIMEOUT /t 3
echo Starting Zoom
TIMEOUT /t 2
start %~dp0/start-zoom.ahk
