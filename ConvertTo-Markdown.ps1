<#
.Synopsis
   Converts a PowerShell object to a Markdown table.
.Description
   The ConvertTo-Markdown function converts a Powershell Object to a Markdown formatted table
.EXAMPLE
   Get-Process | Where-Object {$_.mainWindowTitle} | Select-Object ID, Name, Path, Company | ConvertTo-Markdown

   This command gets all the processes that have a main window title, and it displays them in a Markdown table format with the process ID, Name, Path and Company.
.EXAMPLE
   ConvertTo-Markdown (Get-Date)

   This command converts a date object to Markdown table format
.EXAMPLE
   Get-Alias | Select Name, DisplayName | ConvertTo-Markdown

   This command displays the name and displayname of all the aliases for the current session in Markdown table format

.EXAMPLE
    PS> $sort = [ordered]@{Name=0;DisplayName=0;Options=0}
    PS> Get-Alias | Select Name, DisplayName, Options | ConvertTo-Markdown -columnSorted $sort

   This command generates the markdown table according to the specified order.
#>
Function ConvertTo-Markdown {
    [CmdletBinding()]
    [OutputType([string])]
    Param (
        [Parameter(
            Mandatory = $true,
            Position = 0,
            ValueFromPipeline = $true
        )]
        [PSObject[]]$InputObject,
        [
            ValidateScript({
                If($_.GetType().fullname.split(".")[-1] -eq "OrderedDictionary") 
                {
                    $True
                } Else {
                    Throw "$_ is not an ordered Dictionary!"
                }
            })
        ]
        $columnSorted
    )

    Begin {
        $items = @()

        if($columnSorted -ne $null)
        {
            
            $columns = $columnSorted

        }
        else {
            $columns = @{}
        }

    }

    Process {
        ForEach($item in $InputObject) {
            $items += $item

            $item.PSObject.Properties | %{
                if($_.Value -ne $null){
                    if(-not $columns.Contains($_.Name) -or $columns[$_.Name] -lt $_.Value.ToString().Length) {
                        $columns[$_.Name] = $_.Value.ToString().Length
                    }
                }
            }
        }
    }

    End {
        ForEach($key in $($columns.Keys)) {
            $columns[$key] = [Math]::Max($columns[$key], $key.Length)
        }

        $header = @()
        ForEach($key in $columns.Keys) {
            $header += ('{0,-' + $columns[$key] + '}') -f $key
        }
        $header -join ' | '

        $separator = @()
        ForEach($key in $columns.Keys) {
            $separator += '-' * $columns[$key]
        }
        $separator -join ' | '

        ForEach($item in $items) {
            $values = @()
            ForEach($key in $columns.Keys) {
                $values += ('{0,-' + $columns[$key] + '}') -f $item.($key)
            }
            $values -join ' | '
        }
    }
}