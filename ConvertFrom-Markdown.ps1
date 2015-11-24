# Convert From Markdown Table to PowerShell Object
$myobject = Get-Process | Unique | Select Name, Path, Company
$mddata = $myobject | ConvertTo-Markdown
$data = $mddata | Where-Object {$_ -notmatch "--" }
$object = $data -replace ' +', ''| ConvertFrom-Csv -Delimiter '|'
$object