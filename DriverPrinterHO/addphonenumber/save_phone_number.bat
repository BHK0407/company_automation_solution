@echo off
set /p phone=Please enter your phone number: 
echo %phone% > phone_number.txt

start /wait "" "%~dp0setphone-account-4570.ahk"
timeout /t 5 >nul