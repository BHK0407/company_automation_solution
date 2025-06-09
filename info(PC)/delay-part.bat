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
