Param (
    [Parameter(Mandatory, HelpMessage = "Please provide a valid Name")]
    [string]$Pkg
)

Start-Process msiexec "/i $Pkg /qn";
Start-Process msiexec "/i $Pkg /qn" -Wait;
Start-Process msiexec "/i $Pkg /norestart /qn" -Wait;