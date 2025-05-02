' Disable Task View Button 

' For All users via registry 

' Define the constant for the HKEY_LOCAL_MACHINE registry hive 
Const HKEY_LOCAL_MACHINE = &H80000002


' Searching via Group Policy Editor and Find it from Registry Editor
' Define the path to Registry key that controls the "Task View Button" feature
strKeyPath1 = "SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
' Name of the Registry Value
strValueName1 = "ShowTaskViewButton"
' Set value to 0
dwValue1 = 0

' Object interact with the Windows Management Instrumentation (WMI) 
Set objRegistry = GetObject("winmgmts:\\.\root\default:StdRegProv")

' Create the Registry Key (if it does not already exist)
objRegistry.CreateKey HKEY_LOCAL_MACHINE, strKeyPath1

' Set the DWORD Value - EnableFeeds to 0
objRegistry.setDWORDValue HKEY_LOCAL_MACHINE, strKeyPath1, strValueName1, dwValue1

' Open Shell Active
Set objShell = CreateObject("WScript.Shell")
objShell.Run "gpupdate /force", 0, True
objShell.Run "taskkill /f /im explorer.exe", 0, True

objShell.Run "explorer.exe" , 0, False

MsgBox "Task View Button has been Disabled.", vbInformation, "Completed"

