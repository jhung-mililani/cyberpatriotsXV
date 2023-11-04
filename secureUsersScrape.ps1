$response = Invoke-WebRequest -Uri “http://127.0.0.1:3000/cpxvi_intro_r2_hsms_e_win10_readme_gtm58ucexp.aspx.html”
$name = New-Guid
$results = @()
$preElements = $response.ParsedHtml.getElementsByTagName("pre")
foreach ($element in $preElements) {
 $results += $element.InnerText
}
$results | out-file -filePath “$($env:TEMP)\$name.tmp”

$temp = Get-Content -Path "$($env:TEMP)\$name.tmp"
$newArr = $temp | Where-Object { $_ -notmatch "password" } | Where-Object { $_ -notmatch "Authorized" }
$newArr | Out-File -FilePath "$($env:USERPROFILE)\Desktop\results.txt"

Remove-Item -Path "$($env:TEMP)\$name.tmp"