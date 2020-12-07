###########################################################################################
# Name: BluBracket POC Test Script 2.0
# Version: 1.0
# Author: Victoria Wallace
# Date: 07 December 2020
#
# Notes: 
#	Initial version (1.0 - 07/12/20)
###########################################################################################

# Start script logging - Will check for file existence first and remove if found

$FileName = "C:\ScriptLogs\blubpoc2.log"
if (Test-Path $FileName) {
  Remove-Item $FileName
}
$TranscriptFile = "C:\ScriptLogs\blubpoc2.log"
Start-Transcript -Path $TranscriptFile

###########################################################################################
# Set variables / Create Functions / Import Modules
###########################################################################################

$BluPOC1DT_Variable1 = @()
$BluPOC2DT_Variable2 = @()

###########################################################################################
# Run Script
###########################################################################################

Copy-Item -Path C:\bludtpoc2.ini -Destination C:\poc2-datactics.bak

Copy-Item -Filter *.txt -Path c:\poc2-datactics -Recurse -Destination C:\pocbb2\datactics

$Computers = Get-Content -Path C:\pocbb2\blubdtpoc2.txt

# Copy item and rename

Write-host "Copy and rename BluPOC1DT Test"
Copy-Item "C:\BluPOC1DT.htm" -Destination "C:\Documents\BluPOC2DT.txt"

###########################################################################################
# Stop script logging - Copies for historical records
###########################################################################################

Write-Host ""
$fileext = get-date -Format hh.mm.ss
Copy-Item -Path C:\Temp\VM_Tasks_BB1.log -Destination C:\Temp\VM_Tasks_BB1_$fileext.log
Stop-Transcript