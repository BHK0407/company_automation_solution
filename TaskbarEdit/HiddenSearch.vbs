' Hidden Search box

' Set registry values in both HKCU and HKU.

' The first setting is SearchBarTaskMode as a DWORD with value 0 – this is still required.

' The second setting is SearchBarTaskModeCache, also a DWORD, but must be set to 1.



Option Explicit

Dim objShell, objFSO, userFolder, profile, ntUser

Set objShell = CreateObject("WScript.Shell")
Set objFSO = CreateObject("Scripting.FileSystemObject")

' Apply to current User

Dim regPath
regPath = "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search\"
objShell.RegWrite regPath & "SearchboxTaskbarMode", 0, "REG_DWORD"
objShell.RegWrite regPath & "SearchboxTaskbarModeCache", 1, "REG_DWORD"

' Modify Default user hive if available
If objFSO.FileExists("C:\Users\Default\NTUSER.DAT") Then
    objShell.Run "reg load HKU\DefaultUser C:\Users\Default\NTUSER.DAT", 0, True
    objShell.Run "reg add ""HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Search"" /v SearchboxTaskbarMode /t REG_DWORD /d 0 /f", 0, True
    objShell.Run "reg add ""HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Search"" /v SearchboxTaskbarModeCache /t REG_DWORD /d 1 /f", 0, True
    objShell.Run "reg unload HKU\DefaultUser", 0, True
End If

' Loop user profiles
Set userFolder = objFSO.GetFolder("C:\Users")

For Each profile In userFolder.SubFolders
    Dim profileName
    profileName = LCase(profile.Name)

    If profileName <> "default" And profileName <> "public" And profileName <> "default user" Then
        ntUser = profile.Path & "\NTUSER.DAT"
        If objFSO.FileExists(ntUser) Then
            If objShell.Run("reg load HKU\TempHive """ & ntUser & """", 0, True) = 0 Then
                objShell.Run "reg add ""HKU\TempHive\SOFTWARE\Microsoft\Windows\CurrentVersion\Search"" /v SearchboxTaskbarMode /t REG_DWORD /d 0 /f", 0, True
                objShell.Run "reg add ""HKU\TempHive\SOFTWARE\Microsoft\Windows\CurrentVersion\Search"" /v SearchboxTaskbarModeCache /t REG_DWORD /d 1 /f", 0, True
                objShell.Run "reg unload HKU\TempHive", 0, True
            End If
        End If
    End If
Next

MsgBox "Done. Please reboot to apply settings to all users.", vbInformation, "Completed"