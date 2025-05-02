#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Check for admin rights
if not A_IsAdmin
{
    Run *RunAs "%A_ScriptFullPath%"  ; Restart script as admin
    ExitApp
}

; Now elevated, run the Group Policy Editor
Run, gpedit.msc

; On Local Group Policy Editor
WinWaitActive, Local Group Policy Editor
Sleep, 300

Send, {Tab}
Send, {Down}

Sleep, 1500

Send, {Enter}
Sleep, 300

; Select Administrative Templates
Send, {Tab 4}
Send, {Down 2}
Sleep, 300

Send, {Enter}	
Sleep, 300

; Select Start Menu and Taskbar
Send, {Tab 4}
Send, {Down 4}
Sleep, 300

Send, {Enter}
Sleep, 300

; Select Remove pinned programs from the Taskbar
Send, {Tab 4}
Send, {Down 95}
Sleep, 500

Send, {Enter}
Sleep, 1000

; On Remove pinned programs list from the Start Menu
WinWaitActive, Remove pinned programs from the Taskbar
Sleep, 300

; Select Enable
Send, {Tab 2}
Send, {Down}
Sleep, 1000

Send, {Enter}
Sleep, 500

; Close Local Group Policy Editor
WinClose, Local Group Policy Editor

; Run the update policy to apply
Run, gpupdate /force
Sleep, 25000

; Restart to reboot
Run, shutdown -r -t 0
