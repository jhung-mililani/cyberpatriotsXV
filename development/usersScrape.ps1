# Generate a unique name for a temporary file
$tempName = New-Guid
# Initialize an empty array to store the inner text of <pre> elements
$rawInnerText = @()

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
$results = $temp | Where-Object { $_ -notmatch "password" } | Where-Object { $_ -notmatch "Authorized" }
# Remove ' (you)' from each line
$results = $results -replace ' \(you\)', ''
# Filter out empty lines and write the results to a file on the Desktop
$results | Where-Object { $_ -ne "" } | Out-File -FilePath "$($env:USERPROFILE)\Desktop\results.txt"

# Delete the temporary file
Remove-Item -Path "$($env:TEMP)\$tempName.tmp"
