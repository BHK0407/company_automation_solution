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
set "logfile=%~dp0setup-part1.log"
echo [%DATE% %TIME%] === Starting Setup Part 1 === > "%logfile%" 2>&1

:: Ping để delay chút
call :log "Delaying with ping..."
ping 127.0.0.1 -n 3 > nul

:: Cấu hình IP, tạo user, đổi tên máy, v.v.
call :log "Running setupIP.exe..."
start "" /wait "%~dp0info\setupIP.exe" >> "%logfile%" 2>&1

call :log "Reading user & IP from text files..."
set /p user=<%~dp0info\user.txt
set /p ip=<%~dp0info\ip.txt

call :log "Setting static IP and DNS..."
netsh int ipv4 set address name="Ethernet" static %ip% >> "%logfile%" 2>&1
netsh int ipv4 set dns name="Ethernet" static "" >> "%logfile%" 2>&1
netsh int ipv4 add dns name="Ethernet" 8.8.8.8 index=2 >> "%logfile%" 2>&1
powershell -command Disable-NetAdapterBinding -Name "*" -ComponentID ms_tcpip6 >> "%logfile%" 2>&1

:: BlockFirstSignIn
call :log "Importing First Sign-In registry settings..."
reg import "%~dp0BlockFirstSignIn\Disable_Privacy_settings_experience_on_user_logon.reg" >> "%logfile%" 2>&1
reg import "%~dp0BlockFirstSignIn\Disable_User_First_Sign-in_Animation.reg" >> "%logfile%" 2>&1

:: TaskbarEdit
call :log "Disabling News and Interests..."
start /min "" %~dp0TaskbarEdit\DisableNewsAndInterests.vbs >> "%logfile%" 2>&1
timeout /t 5 >nul

call :log "Disabling Task View Button..."
start /min "" %~dp0TaskbarEdit\DisableTaskViewButton.vbs >> "%logfile%" 2>&1
timeout /t 5 >nul

call :log "Hiding Search Box..."
start /min "" %~dp0TaskbarEdit\HiddenSearch.vbs >> "%logfile%" 2>&1
timeout /t 5 >nul

call :log "Importing taskbar reset registry..."
reg import "%~dp0TaskbarEdit\Disable_and_Hide_pinned_apps_on_taskbar.reg" >> "%logfile%" 2>&1

:: Hidden search Box via PowerShell
call :log "Executing SearchBox.ps1..."
powershell -ExecutionPolicy Bypass -File "%~dp0TaskbarEdit\SearchBox.ps1" >> "%logfile%" 2>&1
timeout /t 2 >nul

:: User creation and rename
call :log "Creating user %user%..."
net user %user% /add >> "%logfile%" 2>&1
net user %user% /passwordchg:no >> "%logfile%" 2>&1
wmic UserAccount where Name='%user%' set PasswordExpires=False >> "%logfile%" 2>&1
WMIC Computersystem where Name='%computername%' Call Rename Name='%user%' >> "%logfile%" 2>&1

:: Flag
call :log "Writing flag file after_reboot.flag..."
echo done > "%~dp0after_reboot.flag"

:: RunOnce setup for part 2
call :log "Registering setup-part2.bat with RunOnce..."
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnce" /v ContinuePOSSetup /t REG_SZ /d "\"%~dp0setup-part2.bat\"" /f >> "%logfile%" 2>&1

:: Restart
call :log "Restarting system in 5 seconds..."
shutdown /r /t 5 /c "System will restart to apply taskbar changes." /f

goto :eof

:: === Hàm ghi log có timestamp ===
:log
set "ts=[%DATE% %TIME%]"
echo !ts! %~1 >> "%logfile%"
echo %~1
goto :eof
