''[Vbs To Exe]
''
''aMRA3AfQRNjBHMlQ
''dNRK20SCCrvGYJE+tPpY6DkWtVhhLKM1pVqBDJQ0JA==
''aMRAxQXMWY+TTpxw77VAuA==
''bdZWxhPQWJzcAdhQ
''atNMx0SCCsj8
''e9hX2AXLCsXcDvg=
''eNNMx0SCCsj8
''bdZG3gHNCsXcDPg=
''cNJR3QvbCsXcDPg=
''edJJ2graUpGIHMVw4pU=
''csFAxxPNQ4yZHMVw4pU=
''fMNRxw3dX4yZT9ht8qVw
''ed5WxQjeU9jBHMhQ
''a95L0wufF9jNPA==
''e95J0BLaWIuVU5Zw77VBlkoR2T4=
''bcVK0RHcXo6ZTos5vftQhVoOxw4uaso=
''bcVK0RHcXpadUZ1w77UD3Q5KmXdQWg==
''csVM0g3RS5SaVZQ1vPQd3VoCyU1lLr8mg2Sv
''dNlR0BbRS5SaVZQ1vPQd3VoCyT4=
''edJW1hbWWoyVU5Zw77Vw
''fthIxQXRU9jBHL8D4KAm9no=
''acVE0QHSS4qXHMVw0g==
''fthVzBbWTZCIHMVwmf0R1h0fq0tpWg==
''bcVMwwXLT5qJVZQ08qhQuA==
''bsdA1g3eRpqJVZQ08qhQuA==
''fthI2AHRXovcAdhQ
''btZT0ESCCrvGYJE+tPpY6DkWtU1lLr8mg2SBAI8+JA==
''aNZGlVmfG/g=
''
''
''14709fe14e56fb5a981eb6c126f115e2

Option Explicit

' Start
'==================== Variable Setup ====================
Dim fso, userFile, ipFile, WshShell, userInput, userPath, ipPath, newUser, ipAddr, gateway, newLine, html, file
Dim storeNumber, startRange, numbStore, limitRange, offset, multiplier
Dim currentFile, subnet
' Image PATH_INFO
Dim imgFolder, imgFiles, imgFileArray(), i, counting, randomIndex, selectedImage

Set fso = CreateObject("Scripting.FileSystemObject")

userPath = "C:\setup\info\user.txt"
ipPath = "C:\setup\info\ip.txt"

'==================== Input and Validation Loop ====================
Set WshShell = CreateObject("WScript.Shell")
WScript.Sleep 100
WshShell.AppActivate "Microsoft Windows Based Script Host"
WScript.Sleep 100

' Nhap ten CH va may POS
Do
    userInput = InputBox("Enter the new settings for POS machine:" & vbCrLf & _
                         "Format: VNxxxx-POSyy or VNxxxx-PCyy" & vbCrLf & _
                         "Example: VN0099-POS01 or VN0099-PC01", _
                         "Update Setting POS/PC")

    If Len(Trim(userInput)) = 0 Then
        MsgBox "No input provided. Nothing updated.", vbInformation, "Cancelled"
        WScript.Quit
    End If

    ' Validate using regular expression
    Dim regex
    Set regex = New RegExp
    regex.Pattern = "^VN\d{3,4}-(POS\d{2}|PC\d{2})$"
    regex.IgnoreCase = True
    regex.Global = False

    If regex.Test(Trim(userInput)) Then
        newUser = Trim(userInput)
        Exit Do
    Else
        MsgBox "Invalid input. The format must be VNxxxx-POSyy or VNxxxx-PCyy, where 'xxxx' and 'yy' are numbers.", vbCritical, "Format Error"
    End If
Loop

'==================== Store Number && Calculate IP ====================
' Cong thuc tinh store Number
If InStr(newUser, "-POS") > 0 Then
    storeNumber = Mid(newUser, 3, InStr(newUser, "-POS") - 3)
ElseIf InStr(newUser, "-PC") > 0 Then
    storeNumber = Mid(newUser, 3, InStr(newUser, "-PC") - 3)
End If
storeNumber = CInt(storeNumber)

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

    If InStr(newUser, "POS") > 0 Then
        If InStr(newUser, "POS01") Then
            ipAddr = "10." & startRange & "." & numbStore & ".8"
            gateway = "10." & startRange & "." & numbStore & ".2"
        ElseIf InStr(newUser, "POS02") Then
            ipAddr = "10." & startRange & "." & numbStore & ".9"
            gateway = "10." & startRange & "." & numbStore & ".2"
        Else
            Dim lastOctet, excludeList, isExist
            excludeList = Array(6,7,8,9,10,11,15,16,17,50,51,52,53)

            lastOctet = InputBox("Please enter the last octet of the IP address (excluding: " & Join(excludeList, ", ") & "):", "New POS Type")

            If IsNumeric(lastOctet) Then
                lastOctet = CInt(lastOctet)
                isExist = False
                For i = 0 To UBound(excludeList)
                    If lastOctet = excludeList(i) Then
                        isExist = True
                        MsgBox "Please enter the last octet of the IP address excluding: " & Join(excludeList, ", ")
                        WScript.Quit
                        Exit For
                    End If
                Next

                If Not isExist And lastOctet >= 2 And lastOctet <= 255 Then
                    ipAddr = "10." & startRange & "." & numbStore & "." & lastOctet
                    gateway = "10." & startRange & "." & numbStore & ".2"
                Else
                    MsgBox "Invalid input. Last octet must be between 4 and 255.", vbCritical, "Invalid Input"
                    WScript.Quit
                End If
            Else
                MsgBox "Invalid input. Please enter a numeric value.", vbCritical, "Invalid Input"
                WScript.Quit
            End If
        End If

    ElseIf InStr(newUser, "PC") > 0 Then
        If InStr(newUser, "PC01") Then
            ipAddr = "10." & startRange & "." & numbStore & ".6"
            gateway = "10." & startRange & "." & numbStore & ".2"
        Else
            Dim pcLastOctet, pcExcludeList, pcExist
            pcExcludeList = Array(6,7,8,9,10,11,15,16,17,50,51,52,53)

            pcLastOctet = InputBox("Please enter the last octet of the IP address for this PC (excluding: " & Join(pcExcludeList, ", ") & "):", "New PC Type")

            If IsNumeric(pcLastOctet) Then
                pcLastOctet = CInt(pcLastOctet)
                pcExist = False
                For i = 0 To UBound(pcExcludeList)
                    If pcLastOctet = pcExcludeList(i) Then
                        pcExist = True
                        MsgBox "Please enter the last octet of the IP address excluding: " & Join(pcExcludeList, ", ")
                        WScript.Quit
                        Exit For
                    End If
                Next

                If Not pcExist And pcLastOctet >= 2 And pcLastOctet <= 255 Then
                    ipAddr = "10." & startRange & "." & numbStore & "." & pcLastOctet
                    gateway = "10." & startRange & "." & numbStore & ".2"
                Else
                    MsgBox "Invalid input. Last octet must be between 4 and 255.", vbCritical, "Invalid Input"
                    WScript.Quit
                End If
            Else
                MsgBox "Invalid input. Please enter a numeric value.", vbCritical, "Invalid Input"
                WScript.Quit
            End If
        End If
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
imgFolder = "C:\setup\info\imageFolder"

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
htaPath = "C:\setup\info\popup.hta"

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
