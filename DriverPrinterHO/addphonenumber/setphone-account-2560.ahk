#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


targetPrinter1 := "FUJIFILM Apeos 2560"

; Open devices and printers
Run, explorer.exe Shell:::{A8A91A66-3A7D-4424-8D24-04E180695C7A}
WinWaitActive, Devices and Printers
Sleep, 1500

; Search for target Printer1
Send, ^f	; Ctrl+F to focus Search
Sleep, 500

Send, %targetPrinter1%
Sleep, 1000

Send, {Enter}
Sleep, 1500


; Focus out of Search
Send, {Esc}
Sleep, 500

; targetPrinter1 show
Send, {Right}
Sleep, 500

; Right all Key
Send, {AppsKey}
Sleep, 500

; Choose 'Printing Properties'
Send, {Down 4};
Sleep, 500

Send, {Enter}
Sleep, 1000

; Printing Properties
WinWaitActive, FUJIFILM Apeos 2560 Properties
Sleep, 500

; Choose Configuration
Send, ^{Tab 7}
Sleep, 1000


; Move to 'Accounting'
Send, {Tab 3}
Sleep, 1000

Send, {Enter}
Sleep, 500

; On Accounting, select Specify Job Owner Name
WinWaitActive, Accounting
Sleep, 500

Send, {Tab}
Sleep, 1000

Send, {Up}	; To select 'Enter Owner name' Option
Sleep, 1000

; Send to userID
Send, {Tab}
Sleep, 500

; Read phone number from the line
FileRead, phoneNumber, phone_number.txt

; Trim whitespace or newlines
phoneNumber := Trim(phoneNumber)


SendInput, %phoneNumber%	; Enable number from FileRead
Sleep, 500

Send, {Enter}
Sleep, 500


; Close and FUJIFILM Apeos 2560 Properties
WinWaitActive, FUJIFILM Apeos 2560 Properties
Sleep, 1000

Send, {Tab 2}
Sleep, 500

Send, {Enter}
Sleep, 1000

WinClose, Devices and Printers
Sleep, 1500

; Use the phone Number
MsgBox, The phone number is: %phoneNumber%