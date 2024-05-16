Param (
    [Parameter(Mandatory, HelpMessage = "Please provide a valid Name")]
    [string]$Pkg
)

Start-Process 'msiexec.exe' -ArgumentList "/I $Pkg /qn" -Wait