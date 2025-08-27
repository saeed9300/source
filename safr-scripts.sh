#!/bin/bash

# Define paths
BAT_FILE="/c/Program Files/RealNetworks/SAFR/ares/ares.bat"
VBS_FILE="$HOME/create_shortcut.vbs"

# Get Windows Startup folder path
STARTUP_DIR=$(powershell.exe -NoProfile -Command "[Environment]::GetFolderPath('Startup')" | tr -d '\r')
SHORTCUT_PATH="$STARTUP_DIR\\SAFR Scripts.lnk"

# Create the .bat file
cat > "$BAT_FILE" <<'EOF'
@echo off
cd "C:\Program Files\RealNetworks\SAFR\ares"
"C:\Program Files\RealNetworks\SAFR\jdk\bin\java.exe" -jar ares.jar
pause
EOF

# Create VBScript to generate shortcut
cat > "$VBS_FILE" <<EOF
Set oWS = WScript.CreateObject("WScript.Shell")
sLinkFile = "$SHORTCUT_PATH"
Set oLink = oWS.CreateShortcut(sLinkFile)
oLink.TargetPath = "C:\\Program Files\\RealNetworks\\SAFR\\ares\\ares.bat"
oLink.WindowStyle = 7   ' 7 = Minimized
oLink.WorkingDirectory = "C:\\Program Files\\RealNetworks\\SAFR\\ares"
oLink.Save
EOF

# Run VBScript to create shortcut
cscript //nologo "$VBS_FILE"

# Cleanup
rm "$VBS_FILE"

echo "Shortcut 'SAFR Scripts' created in Startup folder."
