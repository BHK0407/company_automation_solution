#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


; Đặt tên máy in và đường dẫn tới file cài đặt đã lưu
targetPrinter := "FUJI XEROX ApeosPort 4570"
targetFile := "C:\DriverPrinterHO\GS25-4570\HO-4570printer.xfj"


; Use Shell.Application to open printer folder directly: ; Mở cửa sổ Thiết bị và Máy in
Run, explorer.exe shell:::{A8A91A66-3A7D-4424-8D24-04E180695C7A}
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
Send, {Esc} ; Close dropdown / focus out of search box
Sleep, 200
Send, {Tab 2} ; Tab over to printer list (you may need to adjust this to {Tab 3} or {Down})
Sleep, 300

; Đảm bảo biểu tượng máy in được chọn
Send, {Right}
Sleep, 300

; Mở menu chuột phải trên máy in đã chọn
Send, {AppsKey}
Sleep, 500

; Điều hướng và chọn 'Printing preferences' (Tùy chọn in)
Send, {Down 3} ; Adjust if needed		
Sleep, 200

Send, {Enter}
Sleep, 500

; Chờ cửa sổ Printing Preferences mở ra
WinWaitActive, FUJI XEROX ApeosPort 4570 Printing Preferences

; Điều hướng đến nút 'Edit' trong mục Saved Settings
Send, {Tab 8} ; Adjust this number to "Edit"
Sleep, 1500

Send, {Enter}
Sleep, 500

; Chờ cửa sổ Edit Saved Settings mở ra
WinWaitActive, Edit Saved Settings

; Điều hướng đến nút 'Import'
Send, {Tab 4} ; Tab đến nút Import (có thể điều chỉnh)
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

; Tab đến nút OK để xác nhận nhập file
Send, {Tab 2} ; Adjust this to "OK" Button

Send, {Enter}
Sleep, 1000


;Wait for move back to FUJI XEROX ApeosPort 4570 Printing Preferences
WinWaitActive, FUJI XEROX ApeosPort 4570 Printing Preferences

; Focus vào hộp lựa chọn Saved Settings
ControlFocus, ComboBox1, FUJI XEROX ApeosPort 4570 Printing Preferences
Sleep 1000
Send, {Tab 6} ; Di chuyển đến phần Saved Settings (có thể điều chỉnh số tab)
Sleep 1500

; Press Down 3 times to move to the desired saved setting
Send, {Down 3} ; Di chuyển đến cài đặt mong muốn
Sleep, 2000

; Press Enter to select the setting
Send, {Enter}
Sleep, 500

Return

