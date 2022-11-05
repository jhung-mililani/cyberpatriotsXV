@echo off
echo Updating firewall policies... 
::Firewall rules in registry 
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiSpyware /t REG_DWORD /d 0 /f
echo Firewall policies have been updated. 

cmd /k
