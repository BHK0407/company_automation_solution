
Option Explicit

' Start
'==================== Variable Setup ====================
Dim fso, userFile, ipFile, WshShell, userInput, userPath, ipPath, newUser, ipAddr, gateway, newLine, html, file
Dim storeNumber, startRange, numbStore, limitRange, offset, multiplier
Dim currentFile, subnet
' Image PATH_INFO
Dim imgFolder, imgFiles, imgFileArray(), i, counting, randomIndex, selectedImage

Set fso = CreateObject("Scripting.FileSystemObject")

userPath = "C:\setupPOS\info\user.txt"
ipPath = "C:\setupPOS\info\ip.txt"

'==================== Input and Validation Loop ====================
Set WshShell = CreateObject("WScript.Shell")
WScript.Sleep 100
WshShell.AppActivate "Microsoft Windows Based Script Host"
WScript.Sleep 100

' Prompt Enter Input Name
Do
	userInput = InputBox("Enter the new settings for POS machine:" & vbCrLf & _
						 "Format: VNxxxx-POSyy or VNxxxx-PCyy" & vbCrLf & _
						 "Example: VN0099-POS01 or VN0099-PC01", _
						 "Update Setting POS/PC")

    If Len(Trim(userInput)) = 0 Then
        MsgBox "No input provided. Nothing updated.", vbInformation, "Cancelled"
        WScript.Quit
    End If
    
    ' Validate the format to ensure VNxxxx-POSyy or VNxxxx-PCyy
    If InStr(userInput, "VN") = 1 And (InStr(userInput, "-POS") > 0 Or InStr(userInput, "-PC") > 0) Then
        ' Use regular expression to validate that only digits are after "VN"
        Dim regEx, matchResult
        Set regEx = New RegExp
        regEx.IgnoreCase = True 
        regEx.Global = False
        regEx.Pattern = "^VN\d{4}-(POS\d{2}|PC01)$"  ' Only four digits after "VN", POSyy or exactly PC01
        
        ' Test if the input matches the pattern
        If regEx.Test(userInput) Then
            newUser = Trim(userInput)
            Exit Do
        Else
            MsgBox "Invalid input. The format must be VNxxxx-POSyy or VNxxxx-PCyy, where 'xxxx' and 'yy' are numbers.", vbCritical, "Format Error"
        End If
    Else
        MsgBox "Invalid format. Please use: VNxxxx-POSyy or VNxxxx-PCxx", vbCritical, "Format Error"
    End If
Loop

'==================== Store Number && Calculate IP ====================
' Cong thuc tinh store Number
If InStr(newUser, "-POS") > 0 Then
    storeNumber = Mid(newUser, 3, InStr(newUser, "-POS") - 3) ' Check for POS format
ElseIf InStr(newUser, "-PC") > 0 Then
    storeNumber = Mid(newUser, 3, InStr(newUser, "-PC") - 3) ' Check for PC format
End If
storeNumber = CInt(storeNumber) 'Convert to Integer

' Values
startRange = 1
numbStore = storeNumber
limitRange = 255
offset = 20

numbStore = numbStore + offset

If numbStore > (limitRange * 10) Then
    MsgBox "VN" & (numbStore - offset) & " Out of IP Store Range. Not Invalid!", vbCritical, "Error"
    WScript.Quit
Else
    multiplier = (numbStore - 1) \ limitRange
    startRange = startRange + multiplier
    numbStore = numbStore - (limitRange * multiplier)

    ' Default to POS if POSxx is detected
    If InStr(newUser, "POS") > 0 Then
        If InStr(newUser, "POS01") Then
            ipAddr = "10." & startRange & "." & numbStore & ".8"
            gateway = "10." & startRange & "." & numbStore & ".2"
        ElseIf InStr(newUser, "POS02") Then 
            ipAddr = "10." & startRange & "." & numbStore & ".9"
            gateway = "10." & startRange & "." & numbStore & ".2"
        Else
            ' If another POS type, prompt to create a new POS
            MsgBox "This is a new POS type. Please create a new POS configuration in range (5-255).", vbInformation, "New POS Type"
            WScript.Quit ' Quit if new POS type
        End If
    ' Handling for PC01, etc.
    ElseIf InStr(newUser, "PC") > 0 Then ' Corrected ElseIf
        ipAddr = "10." & startRange & "." & numbStore & ".6" ' Default for PC01
        gateway = "10." & startRange & "." & numbStore & ".2"
    End If
End If
subnet = "255.255.255.0"

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
imgFolder = "C:\setupPOS\info\imageFolder"

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
Dim htaPath, htaContent, htaFile
htaPath = "C:\setupPOS\info\popup.hta"

htaContent = "<html><head><title>POS Update Completed</title>" & _
    "<HTA:APPLICATION ID='app' BORDER='none' SCROLL='no' SINGLEINSTANCE='yes' SYSMENU='no' WINDOWSTATE='maximize' SHOWINTASKBAR='no'>" & _
    "<script type='text/javascript'>" & _
    "setTimeout(function() { window.close(); }, 5000);" & _
    "</script>" & _
    "<style>" & _
    "body { margin:0; padding:0; background: url('file:///" & Replace(selectedImage, "\", "/") & "') no-repeat center center fixed; background-size: cover; font-family:sans-serif; }" & _
    ".overlay { position:absolute; top:50%; left:50%; transform:translate(-50%, -50%); color:white; text-align:center; background-color: rgba(0, 0, 0, 0.5); padding: 40px; border-radius: 15px; }" & _
    "h2 { font-size: 36px; margin-bottom: 20px; color: #c46729; }" & _
    "p { font-size: 20px; margin: 5px 0; color: #c46729; }" & _
    "button { padding: 10px 30px; font-size: 18px; margin-top: 20px; cursor: pointer; border: none; background-color: #28a745; color: white; border-radius: 5px; }" & _
    "button:hover { background-color: #76f5e8; }" & _
    "</style></head><body>" & _
    "<div class='overlay'>" & _
    "<h2>POS Update Completed</h2>" & _
    "<p><b>Username: </b>" & newUser & "</p>" & _
    "<p><b>IP Address: </b>" & ipAddr & "</p>" & _
    "<p><b>Subnet: </b>" & subnet & "</p>" & _
    "<p><b>Gateway: </b>" & gateway & "</p>" & _
    "<button onclick='window.close()'>OK</button>" & _
    "<p style='margin-top:10px; font-size:14px; color:#c46729;'>This popup will close in 5 seconds.</p>" & _
    "</div></body></html>"

Set htaFile = fso.CreateTextFile(htaPath, True)
htaFile.Write htaContent
htaFile.Close

WshShell.Run "mshta.exe """ & htaPath & """", 1, False


'==================== IP Format Checker ====================
Function IsValidIP(str)
	Dim regex
	Set regex = New RegExp
	regex.Pattern = "^(25[0-5]|2[0-4][0-9]|1?[0-9]{1,2})(\.(25[0-5]|2[0-4][0-9]|1?[0-9]{1,2})){3}$"
	regex.IgnoreCase = True
	regex.Global = False
	IsValidIP = regex.Test(str)
End Function
