param([string]$InstallDirectory)

$fileList = echo ConvertTo-Markdown.ps1 PSMarkdown.psm1
if ('' -eq $InstallDirectory)
{
    $personalModules = Join-Path -Path ([Environment]::GetFolderPath('MyDocuments')) -ChildPath WindowsPowerShell\Modules

    if (($env:PSModulePath -split ';') -notcontains $personalModules) {
        Write-Warning "$personalModules is not in `$env:PSModulePath"
    }

    if (!(Test-Path $personalModules)) {
        Write-Error "$personalModules does not exist"
    }

    $InstallDirectory = Join-Path -Path $personalModules -ChildPath PSMarkdown
}

if (!(Test-Path $InstallDirectory)) {
    $null = mkdir $InstallDirectory
}

$wc = New-Object System.Net.WebClient
$fileList |
    ForEach-Object {
        $wc.DownloadFile("https://raw.github.com/ishu3101/PSMarkdown/master/$_","$installDirectory\$_")
    }