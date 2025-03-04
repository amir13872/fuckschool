@echo off
setlocal enabledelayedexpansion

:: تنظیم نام فایل پایتون که باید کپی شود
set PYTHON_FILE=btc.py

:: مسیر مقصد در Temp
set DEST_PATH=%TEMP%\%PYTHON_FILE%

:: مسیر Startup
set STARTUP_FOLDER=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup

:: اطمینان از وجود پوشه Startup، در صورت عدم وجود، ایجاد می‌کند
if not exist "%STARTUP_FOLDER%" (
    mkdir "%STARTUP_FOLDER%"
)

:: پیدا کردن مسیر اجرای Python
for /f "delims=" %%a in ('where python') do set PYTHON_EXE=%%a

:: اگر پایتون پیدا نشد، پیام خطا نمایش داده شود
if "%PYTHON_EXE%"=="" (
    echo [✗] خطا: Python در مسیر سیستم یافت نشد.
    echo لطفاً مطمئن شوید که Python در PATH ویندوز اضافه شده است.
    pause
    exit /b
)

:: کپی کردن فایل به مسیر Temp
copy "%PYTHON_FILE%" "%DEST_PATH%" /Y

:: ایجاد میانبر با PowerShell (اصلاح نقل‌قول‌ها)
powershell -command "& {$s=(New-Object -COM WScript.Shell).CreateShortcut(\"%STARTUP_FOLDER%\python_script.lnk\"); $s.TargetPath=\"%PYTHON_EXE%\"; $s.Arguments=\"%DEST_PATH%\"; $s.WorkingDirectory=\"%TEMP%\"; $s.Save()}"

:: بررسی اینکه میانبر به درستی ایجاد شده است یا نه
if exist "%STARTUP_FOLDER%\python_script.lnk" (
    echo [✓] اسکرyesه شد!
) else (
    echo [✗] خطا در اnoید.
)

pause
