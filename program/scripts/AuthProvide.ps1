<# This script downloads Google Credential Provider for Windows from
https://tools.google.com/dlpage/gcpw/, then installs and configures it.
Windows administrator access is required to use the script. #>

<# Set the following key to the domains you want to allow users to sign in from.

For example:
$domainsAllowedToLogin = "solarmora.com,altostrat.com"
#>

$domainsAllowedToLogin = "totaltransportlogistics.us"

Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName PresentationFramework

<# Check if one or more domains are set #>
if ($domainsAllowedToLogin.Equals('')) {
    $msgResult = [System.Windows.MessageBox]::Show('The list of domains cannot be empty! Please edit this script.', 'GCPW', 'OK', 'Error')
    exit 5
}

function Is-Admin() {
    $admin = [bool](([System.Security.Principal.WindowsIdentity]::GetCurrent()).groups -match 'S-1-5-32-544')
    return $admin
}

<# Check if the current user is an admin and exit if they aren't. #>
if (-not (Is-Admin)) {
    $result = [System.Windows.MessageBox]::Show('Please run as administrator!', 'GCPW', 'OK', 'Error')
    exit 5
}

<# Set the required registry key with the allowed domains #>
$registryPath = 'HKEY_LOCAL_MACHINE\Software\Google\GCPW'
$name = 'domains_allowed_to_login'
[microsoft.win32.registry]::SetValue($registryPath, $name, $domainsAllowedToLogin)

$domains = Get-ItemPropertyValue HKLM:\Software\Google\GCPW -Name $name

if ($domains -eq $domainsAllowedToLogin) {
    $msgResult = [System.Windows.MessageBox]::Show('Configuration completed successfully!', 'GCPW', 'OK', 'Info')
}
else {
    $msgResult = [System.Windows.MessageBox]::Show('Could not write to registry. Configuration was not completed.', 'GCPW', 'OK', 'Error')

}