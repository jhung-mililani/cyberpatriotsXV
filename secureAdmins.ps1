# this script secures the Administrators local group
$allowedAdminsPath = "$($env:USERPROFILE)\Desktop\allowedAdmins.txt"
$allowedAdmins = Get-Content $allowedAdminsPath
$unauthAdminsPath = "$($env:USERPROFILE)\Desktop\unauthAdmins.txt"

Write-Host "Warning: Ensure that the list of administrators is correct at [$allowedAdminsPath] before running this script." -ForegroundColor Yellow
Read-Host -Prompt "Press any key to continue..."

try {
    Get-LocalGroupMember -Group Administrators | Where-Object { $allowedAdmins -notcontains $_.Name | "\\" } | select Name | Out-File -FilePath $unauthAdminsList
}
catch [System.IO.DirectoryNotFoundException],[System.IO.FileNotFoundException] {
    Write-Output "The path or file was not found: [$path], did you create a list of allowed users?"
}
catch [System.IO.IOException] {
    Write-Output "IO error with the file: [$path]"
}
finally {
    Write-Output "Changed permissions for unauthorized administrators. Log can be found at [$unauthAdminsPath]"
}