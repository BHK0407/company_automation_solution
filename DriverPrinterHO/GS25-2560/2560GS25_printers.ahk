#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Đặt tên máy in và đường dẫn tới file cài đặt đã lưu
targetPrinter := "FUJIFILM Apeos 2560"
targetFile := "C:\DriverPrinterHO\GS25-2560\HO-2560printer.xfj"

; Use Shell.Application to open printer folder directly: ; Mở cửa sổ thiết bị và máy in
Run, explorer.exe Shell:::{A8A91A66-3A7D-4424-8D24-04E180695C7A}
WinWaitActive, Devices and Printers
Sleep, 1500 ; Wait a little longer for icons to load

; Search for the Printer by typing its name: ; Tìm kiếm máy in đã chỉ định
Send, ^f ; Ctrl+F to Focus Search
Sleep, 300
Send, %targetPrinter%
Sleep, 1000
Send, {Enter}
Sleep, 1500

; Di chuyển tiêu điểm đến danh sách máy in
Send, {Esc}	; Close dropdown / focus out of search box
Sleep, 200
Send, {Tab 2} ; Tab over to printer list (you may need to adjust this to )
Sleep, 300

; Đảm bảo biểu tượng máy in được chọn
Send, {Right}
Sleep, 300

; Mở menu chuột phải trên máy in đã chọn
Send, {AppsKey}
Sleep, 500

; Điều hướng và chọn 'Printing Preferences' (Tùy chọn in)
Send, {Down 3} ; Adjust if needed
Sleep, 200

Send, {Enter}
Sleep, 500

; Chờ cửa sổ Printing Preferences mở ra 
WinWaitActive, FUJIFILM Apeos 2560 Printing Preferences

; Điều hướng đến Logo "Properties" - Saved Settings (khác 4570)
Send, {Tab 11}; Adjust this number to "Properties" Button
Sleep, 1500

; Chờ cửa sổ Edit Saved Settings mở ra
WinWaitActive, Edit Saved Settings

; Điều hướng dẫn nút 'Import'
Send, {Tab 4} ; Tab đến nút 'Import'
Sleep, 1500
Send, {Enter}
Sleep, 500

; Wait for the window title to ensure it's open
WinWaitActive, Select Saved Setting File 

; Nhập đường dẫn đầy đủ của file cài đặt đã lưu
Send, %targetFile%
Sleep, 1000
Send, {Enter}
Sleep, 500

; Chờ quay lại hộp thoại Edit
WinWaitActive, Edit Saved Settings

; Tab đến List of Saved Settings
Send, {Tab 5} ; Adjust this to "List of Saved Settings"
Sleep, 500

; Trỏ đến Config của máy in
Send, {Down 2}
Sleep, 300
Send, {Right}
Sleep, 300

; Tab để chọn dấu điều khiển vị trí
Send, {Tab}
Sleep, 300

; Set lên đầu
Send, {Enter 4}
Sleep 300

; Tab đến nút OK để xác nhận nhập file
Send, {Tab 7} ; Adjust this to "OK" Button

Send, {Enter}
Sleep, 1000

; Chờ cửa sổ Printing Preferences mở ra 
WinWaitActive, FUJIFILM Apeos 2560 Printing Preferences

; Chọn mặc định và OK
Send, {Down 2}
Sleep, 500
Send, {Up 2}
Sleep, 500
Send, {Enter}
Sleep, 500


Return 
