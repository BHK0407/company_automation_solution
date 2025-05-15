#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Check for admin rights
if not A_IsAdmin
{
	Run *RunAs "%A_ScriptFullPath%"	; Restart script as admin
	ExitApp
}

; Run the Group Policy Editor
Run, gpedit.msc

; On Local Group Policy Editor
WinWaitActive, Local Group Policy Editor
Sleep, 300

; Send TAB to Computer Configuration
Send, {Tab}
Sleep, 300

Send, {Enter}
Sleep, 500

; Go down to Administrative Templates
Send, {Down 3}
Sleep, 500

Send, {Enter}
Sleep, 500

; First log in "System" to check "Logon"
Send, {Down 6}
Sleep, 300

Send, {Enter}
Sleep, 1000

; On "Logon"
Send, {Down 27}
Sleep, 500

Send, {Enter}
Sleep, 1000

; On Logon
; ==== Disable "Show first sign-in animation" ====
Send, {Down 16}
Sleep, 1000

Send, {Enter}
Sleep, 1000

; On Show first sign-in animation application => Choose Disable
WinWaitActive, Show first sign-in animation
Sleep, 300

Send, {Tab 2}
Sleep, 500

Send, {Down 2}
Sleep, 500

Send, {Enter}
Sleep, 1000

; Second log in "Windows Components" to check "OBBE"
WinWaitActive, Local Group Policy Editor
Sleep, 500

Send, {BACKSPACE 2}
Sleep, 1000

Send, {Down 7}
Sleep, 1000

Send, {Enter}
Sleep, 1000

Send, {Down 49}
Sleep, 1000

Send, {Enter}
Sleep, 1000

; Go to "Don't launch privacy settings experience on user logon"
Send, {Down}
Sleep, 500

Send, {Enter}
Sleep, 1000

; ==== Enable "Don't launch privacy settings experience on user logon" ===


Send, {Up}
Sleep, 500

Send, {Enter}
Sleep, 1000

; === Close Local Group Policy Editor
WinClose, Local Group Policy Editor
Sleep, 10000

