@echo off
setlocal enabledelayedexpansion

set /p user=<%~dp0user.txt

:: Maintain log from running
set "logfile=%~dp0nextlog.log"
echo [%DATE% %TIME%] === Starting Setup Part 2 === > "%logfile%" 2>&1

:: check flag does exit
call :log "Checking for after_reboot.flag" 
if not exist "%~dp0after_reboot.flag" (
	call :log "Flag file after_reboot.flag does not exist, exiting." 
	exit /b
)

:: power settings & time sync
call :log "Configuring power settings and time sync..." 
powercfg /x -standby-timeout-ac 0 >> "%logfile%" 2>&1
powercfg /x -monitor-timeout-ac 0 >> "%logfile%" 2>&1
w32TM /config /syncfromflags:manual /manualpeerlist:time1.google.com >> "%logfile%" 2>&1
net stop w32time >> "%logfile%" 2>&1
net start w32time >> "%logfile%" 2>&1
w32tm /config /update >> "%logfile%" 2>&1
w32tm /resync >> "%logfile%" 2>&1

:: disable schedule defrag
call :log "Disabling schedule defrag..." 
schtasks /Change /DISABLE /TN "\Microsoft\Windows\Defrag\ScheduledDefrag" >> "%logfile%" 2>&1

:: Copy host File
call :log "Copy hosts file to system..." 
xcopy %~dp0\hosts "C:\Windows\System32\drivers\etc\" /Y >> "%logfile%" 2>&1

:: Unblock
call :log "Unblock file to add to GS25 domain..." 
powershell -Command "Unblock-File -Path '%~dp0\add-Com-domain.ps1'" >> "%logfile%" 2>&1

:: Join company doamin
:: Two way bypasss
call :log "Check connection to domain controller and add..." 
powershell -NoProfile -ExecutionPolicy Bypass  -File "%~dp0\add-Com-domain.ps1"
::powershell Get-Content "%~dp0\add-Com-domain.ps1" | Invoke-Expression
::powershell -Command "Set-ExecutionPolicy Bypass -Scope Process ; '%~dp0\add-Com-domain.ps1'"
timeout /t 10 >nul


:: Deleting flag File
call :log "Deleting Flag file..." 
del "%~dp0after_reboot.flag"  >> "%logfile%" 2>&1

:: Restarting computer 
call :log "Restarting computer to join domain..." 
shutdown /r /t 5 /c "Restarting to %user% join Company domain..." /f >> "%logfile%" 2>&1

:: === Hàm ghi log có timestamp ===
:log
set "ts=[%DATE% %TIME%]"
echo !ts! %~1 >> "%logfile%"
echo %~1
goto :eof

exit /b