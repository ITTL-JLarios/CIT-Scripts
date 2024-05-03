Param (
    [Parameter(Mandatory, HelpMessage = "Please provide a valid Name")]
    [string]$PName
)

winget.exe -e --id $PName --accept-source-agreements
Write-Host "[+] $PName installed"