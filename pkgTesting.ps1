# package testing
function Get-PackageVersion {
    
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [string]$Name
    )

    PROCESS {
        $Package = Get-Package -Name $Name -ErrorAction SilentlyContinue
        if ($package -eq $null) {
            Write
        }
    }
}

Get-PackageVersion

