#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; IP Address (and Port Name) for Black/White-01
ipAdd := "" ; IP you would like to put
targetPrinter := "Black/White-01"

; Check for admin rights
if not A_IsAdmin
{
    Run *RunAs "%A_ScriptFullPath%"  ; Restart script as admin
    ExitApp
}

; Run Launcher
Run, "C:\01.Soft-HO\Driver\ffa3560pcl6220710w636iml\Launcher"
Sleep, 1000

WinWaitActive, Printer Driver Installation
Send, {Enter}
Sleep, 1000

Send, {Space}
Sleep, 1000

Send, {Enter}
Sleep, 500

; Choose Wireless or Ethernet Connection
Send, {Tab 2}
Sleep, 500

Send, {Down}
Sleep, 500

Send, {Enter}
Sleep, 5000


; Enter to exit alert "Printer not found"
Send, {Enter}
Sleep, 1000

; Choose "add printer manually"
Send, {Tab 3}
Sleep, 1000

Send, {Enter}
Sleep, 1000

; Move to Enter IP Address
Send, {Tab 4}
Sleep, 1000

Send, %ipAdd%
Sleep, 2000

Send, {Enter}
Sleep, 5000

Send, {Enter}
Sleep, 5000

; Printer Settings
Send, {Tab 3}
Sleep, 1000

Send, %targetPrinter%
Sleep, 2000

Send, {Enter}
Sleep, 8000

; Ready to Print!
WinClose, Printer Driver Installation
Sleep, 1000

