###########################################################################################
# Name: BluBracket POC1 Test PS Script
# Version: 1.0
# Author: Victoria Wallace
# Date: 16th November 2020
#
# Notes: 
#	Initial version (1.0 - 16/11/20)
###########################################################################################

# Start script logging - Will check for file existence first and remove if found

$FileName = "C:\ScriptLogs\bb_poc1.log"
if (Test-Path $FileName) {
  Remove-Item $FileName
}
$TranscriptFile = "C:\ScriptLogs\bb_poc1.log"
Start-Transcript -Path $TranscriptFile

###########################################################################################
# Set variables / Create Functions / Import Modules
###########################################################################################

$DTBBPOC1_Variable1 = @()
$Datactics_POC1_Variable2 = @()


# List IP addresses for computer
Write-host "IP Addresses" -ForegroundColor Green
Get-CimInstance -Class Win32_NetworkAdapterConfiguration -Filter IPEnabled=$true | Select-Object -ExpandProperty IPAddress

# Assign DNS Domain for Network Adaptor
Write-host "Assign DNS Domain" -ForegroundColor Green
Get-CimInstance -Class Win32_NetworkAdapterConfiguration -Filter IPEnabled=$true | ForEach-Object -Process { $_.SetDNSDomain('datactics.com') }

# Create Network Share
Write-Host "Network Share" -ForegroundColor Green
(Get-CimInstance -List |
  Where-Object {$_.Name -eq 'DTBBPOC1_Share'}).Create(
    'C:\BluBracket','BluBracketShare',0,25,'test share of the Blubracket folder'
  )

# List Windows Installer Applications
Write-Host "Windows Installer Apps" -ForegroundColor Green
Get-CimInstance -Class Win32_Product |
Where-Object Name -eq "Datactics_POC1 - 2.1.5 (x64)"

# List Uninstallable Applications
Write-Host "Uninstallable Apps" -ForegroundColor Green
New-PSDrive -Name Uninstall -PSProvider Registry -Root HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall

# Install DTBBPOC1
Write-Host "Install DTBBPOC1" -ForegroundColor Green
Invoke-CimMethod -ClassName Win32_Product -MethodName Install -Arguments @{PackageLocation='\\Datactics\BBPOC\DTBBPOC1.msi'}

# Copy file to DatacticsBBPOC1
Write-Host "Copy to DatacticsBBPOC1"
Copy-Item -Path C:\DatacticsBBPOC1.ini -Destination C:\DatacticsBBPOC1.bak

# Copy to new folder
Write-Host "Copy Datactics AccessKeys to Datactics_POC1"
Copy-Item C:\Datactics\AccessKeys -Recurse C:\Datactics\Datactics_POC1

###########################################################################################
# Stop script logging - Copies for historical records
###########################################################################################

Write-Host ""
$fileext = get-date -Format hh.mm.ss
Copy-Item -Path C:\Temp\VM_Tasks.log -Destination C:\Temp\VM_Tasks_$fileext.log
Stop-Transcript