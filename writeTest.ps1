$APIKey     = 'secret_'
$APIURI     = 'https://api.notion.com/v1'
$APIVersion = '2022-06-28'
$GUID       = 'ac035a2585784592b71a3953b37d3016'
$Content = Get-Content -Path "C:\Users\CClub\Desktop\example.txt" -Raw

$Params = @{
    "Headers" = @{
        "Authorization"  = "Bearer {0}" -F $APIKey
        "Content-type"   = "application/json"
        "Notion-Version" = "{0}" -F $APIVersion
    }
    "Method"  = 'PATCH'
    "URI"     = ("{0}/blocks/{1}/children" -F $APIURI, [GUID]::new($GUID))
    "Body"    = @{
        "children" = @(
            @{
                "paragraph" = @{
                    "rich_text" = @(
                        @{
                            "text" = @{
                                "content" = $Content
                            }
                        }
                    )
                }
            }
        )
    } | ConvertTo-JSON -Depth 100
}

$Result = Invoke-RestMethod @Params