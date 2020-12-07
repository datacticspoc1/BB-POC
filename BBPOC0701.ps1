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

$FileName = "C:\ScriptLogs\blubpoc1.log"
if (Test-Path $FileName) {
  Remove-Item $FileName
}
$TranscriptFile = "C:\ScriptLogs\blubpoc1.log"
Start-Transcript -Path $TranscriptFile

###########################################################################################
# Set variables / Create Functions / Import Modules
###########################################################################################

$BluDTPOC1_Variable1 = @()
$BluDTPOC2_Variable2 = @()

###########################################################################################
# Run Script
###########################################################################################

Copy-Item -Path C:\bbdtpoc.ini -Destination C:\bludtpoc1.bak

Copy-Item -Filter *.txt -Path c:\bludtpoc1 -Recurse -Destination C:\bbdtpoc.ini

# Copy info to CSV for offline use

$BB_Host = $env:computername | Export-Csv C:\Temp\BluDTPOC1.csv
$BB_Buckets = Get-S3Object -BucketName text-content -Key aws-tech-docs | Export-Csv c:\Temp\BluDTPOC2.csv


###########################################################################################
# Stop script logging - Copies for historical records
###########################################################################################

Write-Host ""
$fileext = get-date -Format hh.mm.ss
Copy-Item -Path C:\Temp\VM_Tasks_BB.log -Destination C:\Temp\VM_Tasks_BB_$fileext.log
Stop-Transcript