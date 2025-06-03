@echo off

set /p phone=Please enter your phone number: 
echo %phone% > %~dp0\addphonenumber\phone_number.txt

:main_menu
cls

echo ===============================
echo Choose an option to install:
echo 1. FUJI XEROX ApeosPort 4570
echo 2. FUJIFILM Apeos 2560
echo ===============================


choice /c 12 /n /m "Enter your choice (1 or 2): "

if errorlevel 2 (
    echo Installing FUJIFILM Apeos 2560...
	start /wait %~dp0\ffa3560pcl6220710w636iml\BlackWhiteLauncher01.exe
	pause
	start /wait %~dp0\ffa3560pcl6220710w636iml\2560HO_printers.exe
    if %ERRORLEVEL% EQU 0 (
        echo FUJIFILM Apeos 2560 installed successfully.
    ) else (
        echo Exit code: %ERRORLEVEL%
    )
	echo Add phone to config...
	start /wait %~dp0\addphonenumber\setphone-account-2560.exe
	timeout /t 2 >nul
	
) else (
    echo Installing FUJI XEROX ApeosPort 4570...
	start /wait %~dp0\fxap5570pcl6200610w616iml\BlackWhiteLauncher02.exe
	pause
	start /wait %~dp0\fxap5570pcl6200610w616iml\4570HO_printers.exe
    if %ERRORLEVEL% EQU 0 (
        echo FUJI XEROX ApeosPort 4570 installed successfully.
    ) else (
        echo Exit code: %ERRORLEVEL%
    )
	echo Add phone to config...
	start /wait %~dp0\addphonenumber\setphone-account-4570.exe
	timeout /t 2 >nul
)

echo.
choice /c YN /n /m "Do you want to install another printer? (Y/N): "
if %errorlevel% == 1 (
	goto main_menu
) else (
	echo Exiting installer. Thank you!
)

pause