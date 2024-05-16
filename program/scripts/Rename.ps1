Param(
    [string]$NewName
)

Rename-Computer -NewName $NewName
Write-Host "Your new name will be display after restarting the computer."