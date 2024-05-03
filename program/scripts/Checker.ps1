# Check if Windows is activated
$activationStatus = (cscript /NoLogo "c:\Windows\system32\slmgr.vbs" /xpr) -join ''

# Check Windows Version
$WindowsVersion = (Get-WmiObject -Class Win32_OperatingSystem).caption
Write-Host $WindowsVersion

# Check windows activation
if ($activationStatus -like "*activated*") {
    Write-Host "[+] Windows is activated."
    cscript /NoLogo "c:\Windows\system32\slmgr.vbs" /dli
} else {
    Write-Host "[!] Windows is not activated. Details:"
    cscript /NoLogo "c:\Windows\system32\slmgr.vbs" /dli
}

# Check if connected to a KMS server
$dnsResult = Resolve-DnsName -Name "_vlmcs._tcp" -Server "localhost"
if ($dnsResult) {
    Write-Host "[!] Connected to a KMS server."
} else {
    Write-Host "[+] Not connected to a KMS server."
}