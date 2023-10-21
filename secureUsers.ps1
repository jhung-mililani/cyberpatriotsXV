# this script compares the current users against a list of allowed users, and removes unauthorized users.

$allowedUsersPath = "$($env:USERPROFILE)\Desktop\allowedUsers.txt"
$allowedUsers = @(Get-Content $allowedUsersPath)
$unauthUserPath = "$($env:USERPROFILE)\Desktop\unauthUsers.txt"
$unauthUsers = Get-LocalUser | Where-Object { $allowedUsers -notcontains $_.Name }

Write-Host "Warning: Ensure you've created the file allowedUsers.txt at [$allowedUsersPath], case-sensitive, with the users from both the administrator and user sections of the readme before running this script." -ForegroundColor Yellow
Read-Host -Prompt "Press any key to continue"

try
{
    $unauthUsers | Select-Object -ExpandProperty Name | Out-File -FilePath $unauthUserPath
    $unauthUsers | Remove-LocalUser -Confirm -ErrorAction Inquire
    Write-Host "Done removing unauthorized users, log can be found at [$unauthUserPath]" -ForegroundColor Green
    Read-Host -Prompt "Press any key to exit"
}
catch {
    Write-Host "An error occurred: $($_.Exception.Message)" -ForegroundColor Red
}