# Convert From Markdown Table to PowerShell Object
function ConvertFrom-Markdown($InputObject){
    $myobject = $InputObject
    $mddata = $myobject
    $data = $mddata | Where-Object {$_ -notmatch "--" }
    $object = $data -replace ' +', ''| ConvertFrom-Csv -Delimiter '|'
    $object
}