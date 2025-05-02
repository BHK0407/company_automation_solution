' Disable News and Interests Project

' For All users via registry 

' Define the constant for the HKEY_LOCAL_MACHINE registry hive 
Const HKEY_LOCAL_MACHINE = &H80000002

' Searching via Group Policy Editor and Find it from Registry Editor
' Define the path to Registry key that controls the "News and Interests" feature
strKeyPath = "SOFTWARE\Policies\Microsoft\Windows\Windows Feeds"
' Name of the Registry Value
strValueName = "EnableFeeds"
' Set value to 0
dwValue = 0

' Object interact with the Windows Management Instrumentation (WMI) 
Set objRegistry = GetObject("winmgmts:\\.\root\default:StdRegProv")

' Create the Registry Key (if it does not already exist)
objRegistry.CreateKey HKEY_LOCAL_MACHINE, strKeyPath

' Set the DWORD Value - EnableFeeds to 0
objRegistry.setDWORDValue HKEY_LOCAL_MACHINE, strKeyPath, strValueName, dwValue

' Open Shell Active
Set objShell = CreateObject("WScript.Shell")
objShell.Run "gpupdate /force", 0, True
objShell.Run "taskkill /f /im explorer.exe", 0, True

objShell.Run "explorer.exe" , 0, False

MsgBox "News and Interests has been Disabled.", vbInformation, "Completed"

