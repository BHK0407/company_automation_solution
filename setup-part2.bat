@echo off
setlocal enabledelayedexpansion

:: === Hiển thị ASCII Art Logo với hiệu ứng màu và nghiêng ===
echo.
powershell -Command "Write-Host '     ###########################################################################' -ForegroundColor White"
powershell -Command "Write-Host '      #  .d888888             dP                                  dP            #' -ForegroundColor White"
powershell -Command "Write-Host '       # d8''    88             88                                  88            #' -ForegroundColor White"
powershell -Command "Write-Host '        # 88aaaaa88a dP    dP d8888P .d8888b. 88d8b.d8b. .d8888b. d8888P .d8888b. #' -ForegroundColor White"
powershell -Command "Write-Host '         # 88     88  88    88   88   88''  `88 88''`88''`88 88''  `88   88   88ooood8 #' -ForegroundColor White"
powershell -Command "Write-Host '          # 88     88  88.  .88   88   88.  .88 88  88  88 88.  .88   88   88.  ... #' -ForegroundColor White"
powershell -Command "Write-Host '           # 88     88  `88888P''   dP   `88888P'' dP  dP  dP `88888P8   dP   `88888P'' #' -ForegroundColor White"
powershell -Command "Write-Host '            #                                                                         #' -ForegroundColor White"
powershell -Command "Write-Host '             #                                                                         #' -ForegroundColor White"
powershell -Command "Write-Host '              #                    .88888.  .d88888b  d8888b. 888888P                   #' -ForegroundColor Cyan"
powershell -Command "Write-Host '               #                   d8''   `88 88.    ''     `88 88''                        #' -ForegroundColor Cyan"
powershell -Command "Write-Host '                #                   88        `Y88888b. .aaadP'' 88baaa.                   #' -ForegroundColor Cyan"
powershell -Command "Write-Host '                 #                   88   YP88       `8b 88''         `88                   #' -ForegroundColor Cyan"
powershell -Command "Write-Host '                  #                   Y8.   .88 d8''   .8P 88.          88                   #' -ForegroundColor Cyan"
powershell -Command "Write-Host '                   #                    `88888''   Y88888P  Y88888P d88888P                   #' -ForegroundColor Cyan"
powershell -Command "Write-Host '                    ###########################################################################' -ForegroundColor Cyan"
powershell -Command "Write-Host ''"
powershell -Command "Write-Host '                              ──────── ' -ForegroundColor White -NoNewline; Write-Host 'GS25' -ForegroundColor Cyan -NoNewline; Write-Host ' Automator ────────' -ForegroundColor White"
echo.
timeout /t 1 >nul

:: === Thiết lập log file ===
set "logfile=%~dp0setup-part2.log"
echo [%DATE% %TIME%] === Starting Setup Part 2 === > "%logfile%" 2>&1

:: Kiểm tra flag tồn tại để chắc chắn chỉ chạy sau khi reboot
if not exist "%~dp0after_reboot.flag" (
    call :log "Flag file after_reboot.flag does not exist, exiting."
    exit /b
)

call :log "Starting setup-part2.bat..."

call :log "Installing 7zip..."
start /wait "%~dp0\7z1900-x64.exe" /S >> "%logfile%" 2>&1

call :log "Installing NodeJS..."
start /wait msiexec.exe /i "%~dp0\nodejs\node.msi" /quiet >> "%logfile%" 2>&1

call :log "Installing WebView2..."
start /wait "%~dp0\webview\WebView2X64.exe" /silent /install >> "%logfile%" 2>&1

call :log "Installing OneDrive..."
start /wait "%~dp0\onedrive\OneDriveSetup.exe" /silent /allusers >> "%logfile%" 2>&1

call :log "Installing SQL Server Express..."
start /wait %~dp0\SQLEXPRADV_x64_ENU\setup.exe /Q /HIDECONSOLE=1 /ACTION=INSTALL /IACCEPTSQLSERVERLICENSETERMS=1 /FEATURES=SQLENGINE,Tools /UPDATEENABLED=0 /INSTANCENAME="sqlexpress" /ADDCURRENTUSERASSQLADMIN=1 /SECURITYMODE=SQL /SKIPRULES=RebootRequiredCheck /SAPWD="" /SQLSVCSTARTUPTYPE=AUTOMATIC /BROWSERSVCSTARTUPTYPE=AUTOMATIC >> "%logfile%" 2>&1

call :log "Importing registry environment settings..."
reg import "%~dp0\invaironment\invaironment_win10.reg" >> "%logfile%" 2>&1
regedit.exe /S "%~dp0\invaironment\Disable_Language_page_in_Settings.reg" >> "%logfile%" 2>&1

call :log "Installing .NET Framework 4.6.1..."
start /wait "%~dp0\NetFramwork4.6.1.exe" /q /norestart >> "%logfile%" 2>&1

call :log "Installing SQL Server Management Studio..."
start /wait "%~dp0\SQLEXPRADV_x64_ENU\SSMS-Setup-ENU.exe" /install /quiet /norestart >> "%logfile%" 2>&1

call :log "Installing SQL Cmd Line Utils..."
start /wait msiexec /i "%~dp0\MsSqlCmdLnUtils.msi" /passive IACCEPTMSSQLCMDLNUTILSLICENSETERMS=YES >> "%logfile%" 2>&1

call :log "Copying Group Policy..."
xcopy "%~dp0\GroupPolicy" "C:\Windows\System32\GroupPolicy" /i /e /s /y >> "%logfile%" 2>&1

call :log "Copying shortcut UpdatorMessage.lnk to Startup..."
xcopy "%~dp0\UpdatorMessage.lnk" "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup" >> "%logfile%" 2>&1

call :log "Copying hosts file..."
xcopy "%~dp0\hosts" "C:\Windows\System32\drivers\etc\" /Y >> "%logfile%" 2>&1

call :log "Setting timezone and synchronizing time..."
tzutil /s "SE Asia Standard Time" >> "%logfile%" 2>&1
reg add "HKCU\Control Panel\International" /V sShortDate /T REG_SZ /D "dd/MM/yyyy" /F >> "%logfile%" 2>&1
w32tm /config /syncfromflags:manual /manualpeerlist:time1.google.com >> "%logfile%" 2>&1
net stop w32time >> "%logfile%" 2>&1
net start w32time >> "%logfile%" 2>&1
w32tm /config /update >> "%logfile%" 2>&1
w32tm /resync >> "%logfile%" 2>&1

call :log "Disabling UAC..."
reg.exe ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1

call :log "Importing Firewall rules..."
netsh advfirewall import "%~dp0\firewall-rule.wfw" >> "%logfile%" 2>&1

call :log "Running PowerShell script to edit SQL service..."
powershell -ExecutionPolicy Bypass -File "%~dp0\edit-sqlservice.ps1" >> "%logfile%" 2>&1

call :log "Stopping and disabling Windows Update service..."
net stop wuauserv >> "%logfile%" 2>&1
sc config wuauserv start= disabled >> "%logfile%" 2>&1

call :log "Disabling Scheduled Defrag task..."
schtasks /Change /DISABLE /TN "\Microsoft\Windows\Defrag\ScheduledDefrag" >> "%logfile%" 2>&1

call :log "Setting Administrator password..."
net user administrator "">> "%logfile%" 2>&1

call :log "Preparing POS bill form setup..."
set /p user=<"%~dp0info\user.txt"
call :log "User name: %user%"

call :log "Setting auto login for user %user%..."
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v AutoAdminLogon /t REG_SZ /d 1 /f >> "%logfile%" 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v DefaultUsername /t REG_SZ /d %user% /f >> "%logfile%" 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v DefaultPassword /t REG_SZ /d "" /f >> "%logfile%" 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v DefaultDomainName /t REG_SZ /d %COMPUTERNAME% /f >> "%logfile%" 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v LimitBlankPasswordUse /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1

call :log "Copying check.exe to C:\Users\Public\..."
copy "%~dp0check.exe" "C:\Users\Public\" /Y >> "%logfile%" 2>&1

call :log "Creating run_once.bat to run check.exe after user login..."
(
echo @echo off
echo timeout /t 2 /nobreak
echo start /wait "" "C:\Users\Public\check.exe"
echo del "C:\Users\Public\check.exe"
echo del "C:\Users\Public\run_once.bat"
echo powershell -Command "Remove-Item '%%ProgramData%%\Microsoft\Windows\Start Menu\Programs\Startup\run_once.lnk' -Force"
) > C:\Users\Public\run_once.bat

call :log "Creating shortcut run_once.lnk in Startup folder..."
powershell -ExecutionPolicy Bypass -Command ^
 "$s='C:\Users\Public\run_once.bat'; $l='C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\run_once.lnk'; $w=New-Object -ComObject WScript.Shell; $sc=$w.CreateShortcut($l); $sc.TargetPath=$s; $sc.WorkingDirectory='C:\Users\Public'; $sc.Save()" >> "%logfile%" 2>&1

call :log "Displaying run_once.bat content..."
type C:\Users\Public\run_once.bat >> "%logfile%" 2>&1

call :log "Deleting flag file after_reboot.flag..."
del "%~dp0after_reboot.flag" >> "%logfile%" 2>&1

call :log "Restarting computer in 5 seconds..."
shutdown /r /t 5 /c "Restarting to auto-login with user %user%..." /f

goto :eof

:: === Hàm ghi log có timestamp ===
:log
set "ts=[%DATE% %TIME%]"
echo !ts! %~1 >> "%logfile%"
echo %~1
goto :eof
