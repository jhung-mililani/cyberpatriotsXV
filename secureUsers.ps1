Write-Output "This script takes the lists of users and administrators on the README page as input, removes unauthorized users on this system, and logs them at [$unauthUserPath]"
Read-Host -Prompt "Press any key to continue"

# Generate a unique name for a temporary file
$tempName = New-Guid
# Initialize an empty array to store the inner text of <pre> elements
$rawInnerText = @()
$defaultAccounts = @("Administrator", "DefaultAccount", "Guest", "WDAGUtilityAccount")
$unauthUserPath = "$($env:USERPROFILE)\Desktop\unauthUsers.txt"

# Get the URL from a .url file on the Desktop
$url = Get-Content -Path "$($env:USERPROFILE)\Desktop\README.url" | Where-Object { $_ -match "url=(.*)" }
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
$rawInnerText | out-file -filePath “$($env:TEMP)\$tempName.tmp”

# Read the temporary file
$temp = Get-Content -Path "$($env:TEMP)\$tempName.tmp"
# Filter out lines containing 'password' and 'Authorized'
$allowedUsers = $temp | Where-Object { $_ -notmatch "password" } | Where-Object { $_ -notmatch "Authorized" }
# Remove ' (you)' from each line
$allowedUsers = $allowedUsers -replace ' \(you\)', '' | Where-Object { $_ -ne "" }

# Delete the temporary file
Remove-Item -Path "$($env:TEMP)\$tempName.tmp"

$unauthUsers = Get-LocalUser | Where-Object { $allowedUsers -notcontains $_.Name } | Where-Object { $defaultAccounts -notcontains $_.Name}

try
{
    $unauthUsers | Select-Object -ExpandProperty Name | Out-File -FilePath $unauthUserPath
    $unauthUsers | Remove-LocalUser -Confirm -ErrorAction Inquire
    Write-Output "Done removing unauthorized users, log can be found at [$unauthUserPath]"
    Read-Host -Prompt "Press any key to exit"
}
catch {
    Write-Output "An error occurred: $($_.Exception.Message)"
}