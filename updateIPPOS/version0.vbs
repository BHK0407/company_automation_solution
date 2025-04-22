Option Explicit

' Start
' Variable neeeds
Dim fso, userFile, ipFile, userInput, userPath, inputs, ipPath, newUser, ipAddr, gateway, newLine
Dim currentFile, subnet

Set fso = CreateObject("Scripting.FileSystemObject")

' File path include
userPath = "C:\setupPOS\info\user.txt"
ipPath = "C:\setupPOS\info\ip.txt"

' Prompt for Enter:

userInput = InputBox("Enter the new settings for POS machine:" & vbCrLf & _
                     "Format: username, IP address, Default gateway" & vbCrLf & _
                     "Example: VN0099-POS01, 10.1.90.8, 10.1.90.2", _
                     "Update Setting POS")

' If user entered Nothing
If Len(Trim(userInput)) = 0 Then
	MsgBox "Not input provided. Nothing updated.", vbInformation, "Cancelled" 
	WScript.Quit
End If

' If user entered Information
inputs = Split(userInput, ",")

If UBound(inputs) <> 2 Then
	MsgBox "Invalid input format. Please try again.", vbCritical, "Error"
	WScript.Quit
End If

' Group Col
newUser = Trim(inputs(0))
ipAddr = Trim(inputs(1))
gateway = Trim(inputs(2))

'==================== Validate IP Address and Gateway ====================
If Not IsValidIP(ipAddr) Then
	MsgBox "Invalid IP address format: " & ipAddr & vbCrLf & "Please enter in x.x.x.x format.", vbCritical, "Error"
	WScript.Quit
End If

If Not IsValidIP(gateway) Then
	MsgBox "Invalid Gateway format: " & gateway & vbCrLf & "Please enter in x.x.x.x format.", vbCritical, "Error"
	WScript.Quit
End If

'==================== IP Format Function ====================
Function IsValidIP(str)
	Dim regex
	Set regex = New RegExp
	regex.Pattern = "^(25[0-5]|2[0-4][0-9]|1?[0-9]{1,2})(\.(25[0-5]|2[0-4][0-9]|1?[0-9]{1,2})){3}$"
	regex.IgnoreCase = True
	regex.Global = False
	IsValidIP = regex.Test(str)
End Function

'==================== Update user.txt ====================

If Len(Trim(newUser)) > 0 Then
	' Overwrite user.txt
	On Error Resume Next
	Set userFile = fso.OpenTextFile(userPath, 2, True) ' 2 = ForWriting, True = create if not exist
	If Err.Number <> 0 Then
		MsgBox "Failed to open file: " & userPath & vbCrLf & "Error: " & Err.Description, vbCritical, "File Error"
		WScript.Quit
	End If
	
	On Error Goto 0
	
	userFile.WriteLine newUser
	userFile.Close

	MsgBox "user.txt has been updated.", vbInformation, "Success"

Else
	MsgBox "Not input provided. 'user.txt' was not updated.", vbInformation, "Cancelled"
End If

'==================== Get existing subnet mask ====================
' Set subnet mask Default

If fso.FileExists(ipPath) Then
	Set ipFile = fso.OpenTextFile(ipPath, 1)
	currentFile = Trim(ipFile.ReadLine)
	ipFile.Close
	subnet = Split(currentFile)(1)
Else
	subnet = "255.255.255.0" 'Default if file missing
End If


'==================== Update ip.txt ====================

newLine = ipAddr & " " & subnet & " " & gateway
set ipFile = fso.OpenTextFile(ipPath, 2 ,True) ' 2 = ForWriting, True = create if not exist
ipFile.WriteLine newLine
ipFile.Close

MsgBox "Update successful!" & vbCrlf & _
		"Username: " & newUser & vbCrlf & _
		"IP Address: " & ipAddr & vbCrlf & _
		"Subnet: " & subnet & vbCrlf & _
		"Gateway: " & gateway, vbInformation, "Done"
