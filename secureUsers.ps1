# this script accesses the README file for a list of authorized users and administrators, checks it against the current list of users on the machine, removes unauthorized users upon user confirmation, and records the results in a log file.
# check if running with administrative privileges 
# if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
#     Write-Output "Please run this script as an administrator."
#     Read-Host -Prompt "Press enter to exit"
#     exit
# } else {
#     Write-Output "This script takes the lists of users and administrators on the README page as input, removes unauthorized users on this system, and logs them at [$unauthUserPath]"
#     Read-Host -Prompt "Press enter to continue"
# }

# Generate a unique name for a temporary file
$tempName = New-Guid
# set the path for the logfile
$unauthUserPath = "$($env:USERPROFILE)\Desktop\unauthUsers.txt"
# Initialize an empty array to store the inner text of <pre> elements
$rawInnerText = @()
# initialize array with the default local user accounts (https://learn.microsoft.com/en-us/windows/security/identity-protection/access-control/local-accounts)
$defaultAccounts = @(
    "Administrator",
    "DefaultAccount",
    "Guest",
    "HelpAssistant",
    "KRBTGT",
    "LOCAL SERVICE",
    "NETWORK SERVICE",
    "SYSTEM",
    "WDAGUtilityAccount"
)

# Get the URL from a .url file on the Desktop
$url = Get-Content -Path "C:\CyberPatriot\README.url" | Where-Object { $_ -match "url=(.*)" }
# Extract the URL from the match
$url = $matches[1]
# Send a web request to the URL
$response = Invoke-WebRequest -Uri "$url"
# Get all <pre> elements from the parsed HTML of the web response
$preElements = $response.ParsedHtml.getElementsByTagName("pre")

# Loop through each pre element and add its InnerText property to the array
foreach ($element in $preElements) {
 $rawInnerText += $element.InnerText
}
# Write the array to a temporary file
$rawInnerText | out-file -filePath "$($env:TEMP)\$tempName.tmp"

# Read the temporary file
$temp = Get-Content -Path "$($env:TEMP)\$tempName.tmp"
# Filter out lines containing 'password' and 'Authorized'
$allowedUsers = $temp | Where-Object { $_ -notmatch "password" } | Where-Object { $_ -notmatch "Authorized" }
# Remove ' (you)' from each line
$allowedUsers = $allowedUsers -replace ' \(you\)', '' | Where-Object { $_ -ne "" }

# Delete the temporary file
Remove-Item -Path "$($env:TEMP)\$tempName.tmp"

# compare the list of local accounts to the default list and the list accessed from the README
$unauthUsers = Get-LocalUser | Where-Object { $allowedUsers -notcontains $_.Name } | Where-Object { $defaultAccounts -notcontains $_.Name}

try
{
    # for every user account in the array, record its name in the logfile
    $unauthUsers | Select-Object -ExpandProperty Name | Out-File -FilePath $unauthUserPath
    # attempt to remove the account with user confirmation
    $unauthUsers | Remove-LocalUser -Confirm -ErrorAction Inquire
    Write-Output "Done removing unauthorized users, log can be found at [$unauthUserPath]"
    Read-Host -Prompt "Press enter to exit"
}
catch {
    Write-Output "An error occurred: $($_.Exception.Message)"
}