@echo off

:: === 1 ===
call :part1

:: === delay ===
call :delay-part

:: === 2 ===
call :part2

echo === Finish ===
pause
exit /b

:part1
::  SM-part1.bat
REM ------------------- BEGIN SM-part1.bat -------------------
@echo off
setlocal enabledelayedexpansion

:: Maintain log from running
set "logfile=%~dp0log.log"
echo [%DATE% %TIME%] === Starting Setup Part 1 === > "%logfile%" 2>&1

:: Delay ping
call :log "Delay with ping..."
ping 127.0.0.1 -n 3 > nul

:: setup IP, create user
call :log "Setup IP for SM..." 
start "" /wait "%~dp0setupIP.exe" >> "%logfile%" 2>&1

:: Load username and IP address
call :log "Reading user & IP from text files..." 
set /p user=<%~dp0user.txt
set /p ip=<%~dp0ip.txt

call :log "Setting static IP and DNS..." 
netsh int ipv4 set address name="Ethernet" static %ip% >> "%logfile%" 2>&1
netsh int ipv4 set dns Name="Ethernet" static 0.0.0.0 >> "%logfile%" 2>&1
netsh int ipv4 add dns Name="Ethernet" 8.8.8.8 index=2 >> "%logfile%" 2>&1

:: Configure firewall
call :log "Configure firewall..."
netsh advfirewall firewall add rule name="ICMPV4" protocol=icmpv4:8,any dir=in action=allow >> "%logfile%" 2>&1
netsh advfirewall firewall set rule group="File and Printer Sharing" new enable=Yes >> "%logfile%" 2>&1


:: Setup Timezone, Date format, computer Name
call :log "Setting timezone and synchronizing time..."
tzutil /s "SE Asia Standard Time" >> "%logfile%" 2>&1
reg add "HKCU\Control Panel\International" /V sShortDate /T REG_SZ /D "dd/MM/yyyy" /F >> "%logfile%" 2>&1

call :log "Creating user %user%..."
WMIC Computersystem where Name='%computername%' Call Rename Name='%user%' >> "%logfile%" 2>&1

:: flag
call :log "Writing flag file after_reboot.flag..."
echo done > "%~dp0after_reboot.flag"

:: RunOnce setup for part 2
call :log "Registering setup-part2.bat with RunOnce..."
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnce" /v ContinuePOSSetup /t REG_SZ /d "\"%~dp0SM-part2.bat\"" /f >> "%logfile%" 2>&1

:: Restart
call :log "Restarting system in 5 seconds..."
shutdown /r /t 5 /c "System will restart to config SM setup for %user%..." /f

:log
set "ts=[%DATE% %TIME%]"
echo !ts! %~1 >> "%logfile%"
echo %~1
goto :eof

REM -------------------- END SM-part1.bat --------------------
exit /b

:delay-part
@echo off
setlocal enabledelayedexpansion

echo -------------------- BEGIN delay.bat --------------------

call :dots "Initializing..."
call :dots "Loading modules..."
call :dots "Processing..."
call :dots "Please wait..."
call :dots "Finalizing..."
call :dots "Almost there..."

echo -------------------- END delay.bat --------------------
goto :eof

:dots
echo %~1
for /L %%i in (1,1,150) do (
    <nul set /p=.
    call :wait
)
echo.
goto :eof

:wait
rem ~200ms delay
ping 127.0.0.1 -n 1 -w 200 > nul
goto :eof

:wait
rem Ping delay: 200ms x 50 dots = ~10 seconds
ping 127.0.0.1 -n 1 -w 200 > nul
goto :eof

:part2
::  SM-part2.bat
REM ------------------- BEGIN SM-part2.bat -------------------
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

:: ===  log  ===
:log
set "ts=[%DATE% %TIME%]"
echo !ts! %~1 >> "%logfile%"
echo %~1
goto :eof

REM -------------------- END SM-part2.bat --------------------
exit /b
