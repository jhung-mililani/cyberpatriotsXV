$defaultGroups = @(
    "Administrators",
    "Remote Desktop Users",
    "Device Owners",
    "Distributed COM Users",
    "Event Log Readers",
    "Guests",
    "Hyper-V Administrators",
    "IIS_IUSRS",
    "Performance Log Users",
    "Performance Monitor Users",
    "Remote Management Users",
    "System Managed Accounts Group",
    "Users"
)
$userGroupsPath = "$($env:USERPROFILE)\Desktop\allowedGroups.txt"
$userGroups = @(Get-Content $userGroupsPath)

$assignedUsersPath = "$($env:USERPROFILE)\Desktop\addUsers.txt"
$assignedUsers = @(Get-Content $assignedUsersPath)

$unauthGroupsPath = "$($env:USERPROFILE)\Desktop\unauthGroups.txt"

$allowedGroups = @(Get-Content $defaultGroups, $userGroups)
$unauthGroups = Get-LocalGroup | Where-Object { $allowedGroups -notcontains $_.Name }

Write-Output "Warning: Ensure that the list of groups is correct at [$userGroupsPath] and the list of users to assign to those groups is correct at [$assignedUsersPath] before running this script."
Read-Host -Prompt "Press any key to continue..."

try
{
    $unauthGroups | Select-Object -ExpandProperty Name | Out-File -FilePath $unauthGroupsPath
    $unauthUsers | Remove-LocalUser -Confirm -ErrorAction Inquire
    Write-Output "Done removing unauthorized users, log can be found at [$unauthGroupsPath]"
    Read-Host -Prompt "Press any key to exit"
}
catch {
    Write-Output "An error occurred: $($_.Exception.Message)"
}