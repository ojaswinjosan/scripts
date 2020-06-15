#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

if WinExist("Start")
{
     WinActivate
}
else
sleep, 3000
send +{tab}
sleep, 1000
send +{tab}
sleep, 1000
send +{tab}
sleep, 1000
send +{tab}
sleep, 3000
send ms-windows-store://pdp/?ProductId=9n0dx20hk701
sleep, 1000
send `n
sleep, 5000
send `n
sleep, 5000
return
