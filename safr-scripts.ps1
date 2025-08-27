$batPath = "C:\Program Files\RealNetworks\SAFR\ares\ares.bat"
$startup = [Environment]::GetFolderPath('Startup')
$shortcutPath = Join-Path $startup "SAFR Scripts.lnk"

# Create .bat file
@"
@echo off
cd "C:\Program Files\RealNetworks\SAFR\ares"
"C:\Program Files\RealNetworks\SAFR\jdk\bin\java.exe" -jar ares.jar
pause
"@ | Set-Content -Path $batPath -Encoding ASCII

# Create shortcut
$ws = New-Object -ComObject WScript.Shell
$sc = $ws.CreateShortcut($shortcutPath)
$sc.TargetPath = $batPath
$sc.WorkingDirectory = "C:\Program Files\RealNetworks\SAFR\ares"
$sc.WindowStyle = 7
$sc.Save()
