$LatestVersion = Invoke-RestMethod -Uri "https://evergreen-api.stealthpuppy.com/app/NotepadPlusPlus" 
$LatestVersion = $LatestVersion | Where-Object { $_.Architecture -eq "x64" -and $_.InstallerType -eq "Default" } | Select-Object -ExpandProperty URI
Invoke-WebRequest $LatestVersion -OutFile "$($env:USERPROFILE)\Desktop\NPPSETUP.exe"