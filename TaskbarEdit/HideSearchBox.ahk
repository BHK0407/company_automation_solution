#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Relaunch with admin if not already elevated
if not A_IsAdmin
{
    Run *RunAs "%A_ScriptFullPath%"
    ExitApp
}

; Hide for CURRENT USER
RegWrite, REG_DWORD, HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search, SearchboxTaskbarMode, 0

; Hide for DEFAULT user (new users)
RegWrite, REG_DWORD, HKEY_USERS\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Search, SearchboxTaskbarMode, 0

; Hide for all LOADED user hives (e.g., HKEY_USERS\S-1-5-21-...)
Loop, Reg, HKEY_USERS, K
{
    if (SubStr(A_LoopRegName, 1, 2) = "S-")
    {
        userKey := A_LoopRegName . "\Software\Microsoft\Windows\CurrentVersion\Search"
        RegWrite, REG_DWORD, HKEY_USERS\%userKey%, SearchboxTaskbarMode, 0
    }
}

; Restart Explorer (affects current user only)
Run, taskkill /f /im explorer.exe
Sleep, 1000
Run, explorer.exe

MsgBox, Search box hidden for all current and future users (loaded profiles).