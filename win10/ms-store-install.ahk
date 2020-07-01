#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Assuming the user is logged in to their Microsoft account.
; The Store may show an extra prompt if not logged in.

if WinExist("Microsoft Store")
{
     WinActivate
}
sleep, 10000
send `n
sleep, 2000
WinMaximize
if WinExist("Administrator")
{
     WinActivate
}
return
