$APIKey     = 'secret_'
$APIURI     = 'https://api.notion.com/v1'
$APIVersion = '2022-06-28'
$PageSize   = '100'
$GUID       = 'ac035a2585784592b71a3953b37d3016'

$Params = @{
    "Headers" = @{
        "Authorization"  = "Bearer {0}" -F $APIKey
        "Content-type"   = "application/json"
        "Notion-Version" = "{0}" -F $APIVersion
    }
    "Method"  = 'GET'
    "URI"     = ("{0}/blocks/{1}/children?page_size={2}" -F $APIURI, [GUID]::new($GUID), $PageSize)
}

$Result = Invoke-RestMethod @Params

$Result.results.paragraph.rich_text