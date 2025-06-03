@echo off
setlocal

set /p phone=Please enter your phone number: 
echo %phone% > %~dp0addphonenumber\phone_number.txt

:main_menu
cls
echo ===============================
echo Choose an option to install:
echo 1. FUJIFILM Apeos 2560
echo 2. FUJI XEROX ApeosPort 4570
echo 3. FUJIFILM Apeos 2560 (HN)
echo ===============================

choice /c 123 /n /m "Enter your choice (1, 2 or 3): "

REM You must check in DESCENDING ORDER
if errorlevel 3 goto install_3
if errorlevel 2 goto install_2
if errorlevel 1 goto install_1

goto end

:install_1
echo Installing FUJIFILM Apeos 2560...
start /wait %~dp0ffa3560pcl6220710w636iml\BlackWhiteLauncher01.exe
pause
start /wait %~dp0ffa3560pcl6220710w636iml\2560HO_printers.exe
if %errorlevel% equ 0 (
    echo FUJIFILM Apeos 2560 installed successfully.
) else (
    echo Exit code: %errorlevel%
)
echo Add phone to config...
start /wait %~dp0addphonenumber\setphone-account-2560.exe
timeout /t 2 >nul
goto ask_again

:install_2
echo Installing FUJI XEROX ApeosPort 4570...
start /wait %~dp0fxap5570pcl6200610w616iml\BlackWhiteLauncher02.exe
pause
start /wait %~dp0fxap5570pcl6200610w616iml\4570HO_printers.exe
if %errorlevel% equ 0 (
    echo FUJI XEROX ApeosPort 4570 installed successfully.
) else (
    echo Exit code: %errorlevel%
)
echo Add phone to config...
start /wait %~dp0addphonenumber\setphone-account-4570.exe
timeout /t 2 >nul
goto ask_again

:install_3
echo Installing FUJIFILM Apeos 2560 (HN)...
start /wait %~dp0ffa3560pcl6220710w636iml-HN\BlackWhiteLauncher03.exe
pause
start /wait %~dp0ffa3560pcl6220710w636iml-HN\2560HO_printers-HN.exe
echo FUJIFILM Apeos 2560 (HN) installed successfully.

echo Add phone to config...
start /wait %~dp0addphonenumber\setphone-account-2560-HN.exe
timeout /t 2 >nul
goto ask_again

:ask_again
echo.
choice /c YN /n /m "Do you want to install another printer? (Y/N): "
if errorlevel 2 (
    echo Exiting installer. Thank you!
    goto end
) else (
    goto main_menu
)

:end
pause
endlocal
