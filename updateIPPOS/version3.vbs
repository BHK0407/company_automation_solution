Option Explicit

' Start
'==================== Variable Setup ====================
Dim fso, userFile, ipFile, WshShell, userInput, userPath, inputs, ipPath, newUser, ipAddr, gateway, newLine, html, file
Dim currentFile, subnet
' Image PATH_INFO
Dim imgFolder, imgFiles, imgFileArray(), i, counting, randomIndex, selectedImage

Set fso = CreateObject("Scripting.FileSystemObject")

userPath = "C:\updateIPPOS\user.txt"
ipPath = "C:\updateIPPOS\ip.txt"

'==================== Input and Validation Loop ====================
Set WshShell = CreateObject("WScript.Shell")
WScript.Sleep 100
WshShell.AppActivate "Microsoft Windows Based Script Host"
WScript.Sleep 100

Do
	userInput = InputBox("Enter the new settings for POS machine:" & vbCrLf & _
						 "Format: username, IP address, Default gateway" & vbCrLf & _
						 "Example: VN0099-POS01, 10.1.90.8, 10.1.90.2", _
						 "Update Setting POS")

	If Len(Trim(userInput)) = 0 Then
		MsgBox "No input provided. Nothing updated.", vbInformation, "Cancelled" 
		WScript.Quit
	End If

	inputs = Split(userInput, ",")

	If UBound(inputs) = 2 Then
		newUser = Trim(inputs(0))
		ipAddr = Trim(inputs(1))
		gateway = Trim(inputs(2))

		If IsValidIP(ipAddr) And IsValidIP(gateway) Then
			Exit Do
		Else
			MsgBox "Invalid IP format detected." & vbCrLf & _
				   "Please use format: x.x.x.x (0-255).", vbCritical, "IP Format Error"
		End If
	Else
		MsgBox "Input must be in this format:" & vbCrLf & _
			   "username, IP address, Default gateway", vbCritical, "Format Error"
	End If
Loop

'==================== Update user.txt ====================
If Len(newUser) > 0 Then
	On Error Resume Next
	Set userFile = fso.OpenTextFile(userPath, 2, True) ' 2 = ForWriting
	If Err.Number <> 0 Then
		MsgBox "Failed to open file: " & userPath & vbCrLf & "Error: " & Err.Description, vbCritical, "File Error"
		WScript.Quit
	End If
	On Error Goto 0

	userFile.WriteLine newUser
	userFile.Close
End If

'==================== Get existing subnet mask ====================
If fso.FileExists(ipPath) Then
	Set ipFile = fso.OpenTextFile(ipPath, 1)
	currentFile = Trim(ipFile.ReadLine)
	ipFile.Close
	subnet = Split(currentFile)(1)
Else
	subnet = "255.255.255.0"
End If

'==================== Update ip.txt ====================
newLine = ipAddr & " " & subnet & " " & gateway
Set ipFile = fso.OpenTextFile(ipPath, 2, True)
ipFile.WriteLine newLine
ipFile.Close

'==================== Confirmation ====================
'MsgBox "Update successful!" & vbCrLf & _
'	   "Username: " & newUser & vbCrLf & _
'	   "IP Address: " & ipAddr & vbCrLf & _
'	   "Subnet: " & subnet & vbCrLf & _
'	   "Gateway: " & gateway, vbInformation, "Done"

'==================== Shuffer Random Image ====================
imgFolder = "C:\updateIPPOS\imageFolder"

Set imgFiles = fso.GetFolder(imgFolder).Files

i = 0
Redim imgFileArray(imgFiles.Count -1)

For Each file In imgFiles
	If LCase(fso.GetExtensionName(file.Name)) = "jpg" Then
		imgFileArray(i) = file.Path
		i = i + 1
	End If
Next

If i = 0 Then
	MsgBox "No .jpg images found in the folder: " & imageFolder, vbCritical, "Image Error"
	WScript.Quit
End If

Redim Preserve imgFileArray(i-1)
Randomize
randomIndex = Int(Rnd*i)
selectedImage = imgFileArray(randomIndex)


'==================== Custom Popup with Logo ====================
Dim IE
Set IE = CreateObject("InternetExplorer.Application")
IE.Visible = True

' Wait and activate IE window
WScript.Sleep 1000
WshShell.AppActivate "Internet Explorer"

' Add result from message box to InternetExplorer
' imageFolder = "C:\updateIPPOS\imageFolder"
'
'

html = "<html><head><style>" & _
       "body { font-family:sans-serif; margin:0; display:flex; justify-content:center; align-items:center; height:100vh; background:#fff; }" & _
       ".container { text-align:center; }" & _
       "img { width:300px; height:auto; margin-bottom:20px; }" & _
       "h2 { color:green; }" & _
       "p { font-size:16px; }" & _
       "button { padding:8px 20px; font-size:14px; margin-top:20px; cursor:pointer; }" & _
       "</style></head><body>" & _
       "<div class='container'>" & _
       "<img src='file:///" & Replace(selectedImage, "\", "/") & "'>" & _
       "<h2>POS Update Completed</h2>" & _
       "<p><b>Username: </b>" + newUser + "<br>" & _
       "<b>IP Address: </b>" + ipAddr + "<br>" & _
	   "<b>Subnet: </b>" + subnet + "<br>" & _
       "<b>Gateway: </b>" + gateway + "<br>" & _
       "<button onclick='window.close()'>OK</button>" & _
       "</div></body></html>"

IE.Navigate "about:blank"
Do While IE.Busy Or IE.ReadyState <> 4
    WScript.Sleep 100
Loop

IE.Document.Open
IE.Document.Write html
IE.Document.Close

' Close IE
WScript.Sleep 5000
IE.Quit


'==================== IP Format Checker ====================
Function IsValidIP(str)
	Dim regex
	Set regex = New RegExp
	regex.Pattern = "^(25[0-5]|2[0-4][0-9]|1?[0-9]{1,2})(\.(25[0-5]|2[0-4][0-9]|1?[0-9]{1,2})){3}$"
	regex.IgnoreCase = True
	regex.Global = False
	IsValidIP = regex.Test(str)
End Function
