#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

if WinExist("Launch Meeting")
{
     WinActivate
}
else
return
sleep, 3000
send {left}
sleep, 1000
send `n
sleep, 5000
if WinExist("Zoom")
{
     WinActivate
}
else
return