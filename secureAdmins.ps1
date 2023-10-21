# this script secures the Administrators local group
$allowedAdminsPath = "$($env:USERPROFILE)\Desktop\allowedAdmins.txt"
$unauthAdminsPath = "$($env:USERPROFILE)\Desktop\unauthAdmins.txt"
$allowedAdminsTempPath = "$($env:USERPROFILE)\Desktop\allowedAdminsTemp.txt"
$unauthAdmins = Get-LocalGroupMember -Group Administrators | Where-Object { (Get-Content $allowedAdminsTempPath) -notcontains $_.Name }

Write-Output "Warning: Ensure that the list of administrators is correct at [$allowedAdminsPath] before running this script."
Read-Host -Prompt "Press any key to continue..."

Get-Content -Path "$allowedAdminsPath" | ForEach-Object { "$($env:COMPUTERNAME)\$_" } | Set-Content -Path "$allowedAdminsTempPath"
Write-Output "[$allowedAdminsPath] modified"

try {
    $unauthAdmins | Select-Object -ExpandProperty Name | Out-File -FilePath "$unauthAdminsPath"
    $unauthAdmins | Remove-LocalGroupMember -Group "Administrators" -Confirm -ErrorAction Inquire
    Write-Output "Changed permissions for unauthorized administrators. User log at: [$unauthAdminsPath]. Keep in mind that the users are still present, just no longer administrators."
    Read-Host "Press any key to exit"
}
catch {
    Write-Output "An error occurred: $($_.Exception.Message)"
}