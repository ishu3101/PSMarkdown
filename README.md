# PSMarkdown
A Powershell Module that lets you convert from a PowerShell object to a Markdown table and back.

## Table of Contents

* [Install](#install)
* [Getting Started](#getting-started)
* [Get Help](#get-help)
* [Commands](#commands)
	* [ConvertTo-Markdown](#convertto-markdown)
	* [ConvertFrom-Markdown](#convertfrom-markdown)
* [Credit](#credit)
* [License](#license)

## Install

To install in your personal modules folder (e.g. ~\Documents\WindowsPowerShell\Modules), run:

```powershell
iex (new-object System.Net.WebClient).DownloadString('https://raw.github.com/ishu3101/PSMarkdown/master/Install.ps1')
```

## Getting Started

To start using, just import the module using

```powershell
Import-Module PSMarkdown
```

After installation, the following commands are available: `ConvertTo-Markdown, ConvertFrom-Markdown`

## Get Help

* List of all available commands

    ```powershell
	Get-Command -Module PSMarkdown
    ```

* Help for a specific command.

    ```powershell
	Get-Help <command>
    ```

## Commands

***For more detailed information about a command use the help***

### ConvertTo-Markdown
Converts a PowerShell object to a Markdown table.

#### Usage
```powershell
ConvertTo-Markdown [-InputObject] <PSObject[]> [<CommonParameters>]
```

#### Example

```powershell
Get-Process | Where-Object {$_.mainWindowTitle} | Select-Object ID, Name, Path, Company | ConvertTo-Markdown
```

```powershell
ConvertTo-Markdown (Get-Date)
```

```powershell
Get-Alias | Select-Object Name, DisplayName | ConvertTo-Markdown
```

### ConvertFrom-Markdown
Converts a Markdown table to a PowerShell object.

#### Usage
```powershell
ConvertFrom-Markdown [-InputObject] <Object> [<CommonParameters>]
```

#### Example

```powershell
Get-Service | Select-Object Name, DisplayName, Status | ConvertTo-Markdown | ConvertFrom-Markdown
```

```powershell
Get-Process | Unique | Select-Object Name, Path, Company | ConvertTo-Markdown | ConvertFrom-Markdown
```

```powershell
ConvertTo-Markdown (Get-Service | Where-Object {$_.Status -eq "Running"} | Select-Object Name, DisplayName, Status) | ConvertFrom-Markdown
```

## Credit

Thanks [Ben Neise](https://github.com/GuruAnt) for the initial code for [ConvertTo-Markdown](https://gist.github.com/GuruAnt/4c837213d0f313715a93) function

## License

PSMarkdown is released under the MIT license. See [LICENSE](LICENSE) for details.
