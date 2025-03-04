@echo off
powershell -Command "Add-MpPreference -ExclusionProcess 'C:\Path\To\Your\Program.exe'"
powershell -Command "Add-MpPreference -ExclusionPath 'C:\Path\To\Your\Folder'"
powershell -Command "Get-MpThreat | ForEach-Object { Restore-MpThreat -ThreatID $_.ThreatID }"
echo The program has been allowed in Windows Defender.
pause



or

@echo off
powershell -Command "Add-MpPreference -ExclusionPath 'C:\Path\To\Your\File.exe'"
echo Exclusion Added Successfully!
pause
