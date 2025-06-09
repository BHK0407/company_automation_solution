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
netsh int ipv4 set dns Name="Ethernet" static 10.0.0.5 >> "%logfile%" 2>&1
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