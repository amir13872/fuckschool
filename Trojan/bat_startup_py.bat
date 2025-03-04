@echo off
set PYTHON_SCRIPT=your_script.py
set TEMP_PATH=%TEMP%\%PYTHON_SCRIPT%
set STARTUP_PATH=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup

:: کپی کردن فایل پایتون به پوشه Temp
copy "%PYTHON_SCRIPT%" "%TEMP_PATH%" /Y

:: ایجاد یک فایل Batch برای اجرای اسکریپت پایتون
echo @echo off > "%STARTUP_PATH%\run_python.bat"
echo python "%TEMP_PATH%" >> "%STARTUP_PATH%\run_python.bat"

:: اضافه کردن تسک به Task Scheduler (اختیاری)
schtasks /create /tn "RunPythonScript" /tr "python %TEMP_PATH%" /sc onlogon /rl highest /f

echo عملیات با موفقیت انجام شد!
pause
