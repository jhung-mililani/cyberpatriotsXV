# Force update Google Chrome
# $Path = $env:TEMP;
# $Installer = "chrome_installer.exe";
$CurrentChromeVersion = $(Get-Package -Name "Google Chrome").Version
$LatestChromeVersion = Invoke-RestMethod -Uri "https://evergreen-api.stealthpuppy.com/app/GoogleChrome"
$LatestChromeVersion = $LatestChromeVersion | Where-Object { $_.Architecture -eq "x64" -and $_.Channel -eq "stable" -and $_.Type -eq "msi" } | Select-Object -ExpandProperty Version

if ($CurrentChromeVersion -ne $LatestChromeVersion) {
    Write-Output Need to update Chrome!
} else {
    Write-Output Chrome is up to date.
}

# if ($CurrentChromeVersion -ne "latest") {
#     Invoke-WebRequest "http://dl.google.com/chrome/install/latest/chrome_installer.exe" -OutFile $Path\$Installer;
#     Start-Process -FilePath $Path\$Installer -Args "/silent /install" -Verb RunAs -Wait;
#     Remove-Item $Path\$Installer
# } else {
#     Write-Output Chrome is up to date.
# }

