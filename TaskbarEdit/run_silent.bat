@echo off
setlocal enableextensions enabledelayedexpansion

:: Get current script folder (without trailing backslash)
set "pwd=%~dp0"
set "pwd=%pwd:~0,-1%"

:: Check for admin rights
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo This script requires administrative privileges.
    pause
    exit /b
)

:: Run scripts silently
start /min "" wscript.exe "%pwd%\DisableNewsAndInterests.vbs"
timeout /t 2 >nul

start /min "" wscript.exe "%pwd%\DisableTaskViewButton.vbs"
timeout /t 2 >nul

start /min "" wscript.exe "%pwd%\HiddenSearch.vbs"
timeout /t 2 >nul

:: Run the compiled AutoHotkey EXE and wait for it to finish
echo Running reset_taskbar_pins.exe...
start "" /wait "%pwd%\reset_taskbar_pins.exe"

:: Final message
msg * Taskbar configuration completed successfully!

:: Create cleanup2 directly in TEMP
set "cleanup2=%TEMP%\_cleanup2.bat"
(
    echo @echo off
    echo timeout /t 2 ^>nul
    echo cd /d "%pwd%"
    echo attrib -h -s -r *.* /s /d
    echo del /f /q *.* ^>nul 2^>nul
    echo cd ..
    echo rmdir /s /q "%pwd%" ^>nul 2^>nul
    echo gpupdate /force
    echo shutdown /r /t 5 /c "System will restart to apply taskbar changes." /f
) > "%cleanup2%"

:: Run cleanup script and exit this script
start "" /min cmd /c "%cleanup2%"
exit
