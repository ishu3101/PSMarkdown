$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"


$csvFile = @'
"hostname","name","type","version"
"Server1","app","windows","2012"
"Server2","os","windows","2008"
'@
$tmpFileName = [System.IO.Path]::GetTempFileName()

Describe "ConvertTo-Markdown" {

    BeforeEach{
        Add-Content -path $tmpFileName -value $csvFile
    }

    It "Count of Csv greather then 1 " {
        $content = import-csv $tmpFileName
        $content.count | Should -BeGreaterThan  1
    }

    It "Order of Columns should be mixed up" {
        $content = import-csv $tmpFileName
        (ConvertTo-Markdown $content)[0].replace(" ","") | Should be "name|hostname|type|version"
    }

    It "Keep order of Columns" {
        $content = import-csv $tmpFileName
        $c = [ordered]@{"hostname"= "0";"name"= "0";"type" = "0";"version"=0}
        (ConvertTo-Markdown $content -columnSorted $c)[0].replace(" ","") | Should be "hostname|name|type|version"
    }

    It "Keep order of Columns from Pipeline" {
        $content = import-csv $tmpFileName
        $c = [ordered]@{"hostname"= "0";"name"= "0";"type" = "0";"version"=0}
        ($content | ConvertTo-Markdown -columnSorted $c)[0].replace(" ","") | Should be "hostname|name|type|version"
    }

    It "Try column sorted should raise an error" {
        $content = import-csv $tmpFileName
        $c = @{"hostname"= "0";"name"= "0";"type" = "0";"version"=0}
        {ConvertTo-Markdown $content -columnSorted $c} | Should -Throw "Cannot validate argument on parameter"
    }

    AfterEach {

            # Remove the File tmpFileName            
            remove-item -path $tmpFileName
            }
        

}
