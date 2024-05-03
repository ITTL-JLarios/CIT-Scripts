Param (
    [Parameter(Mandatory, HelpMessage = "Please provide a valid Path")]
    [string]$Path,
    [Parameter(Mandatory, HelpMessage = "Please provide a valid Name")]
    [string]$PName
)

Start-Process -FilePath "$Path" -ArgumentList "/S"
Write-Host "[+] $Name installed"