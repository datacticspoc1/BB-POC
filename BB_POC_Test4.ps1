###########################################################################################
# Name: BluBracket POC Test PS Script
# Version: 1.0
# Author: Dave Brown
# Date: 12th November 2020
#
# Notes: 
#	Initial version (1.0 - 12/11/20)
###########################################################################################

# Start script logging - Will check for file existence first and remove if found

$FileName = "C:\ScriptLogs\bb_poc.log"
if (Test-Path $FileName) {
  Remove-Item $FileName
}
$TranscriptFile = "C:\ScriptLogs\bb_poc.log"
Start-Transcript -Path $TranscriptFile

###########################################################################################
# Set variables / Create Functions / Import Modules
###########################################################################################

$DT_BFS_BB_POC5_Variable1 = @()
$DT_BFS_BB_POC6_Variable2 = @()

###########################################################################################
# Run Script
###########################################################################################

Write-Host ""
Write-Host "Test BluBracket Code Copy"
Write-Host ""

$BB_Host = $env:computername
$BB_Buckets = Get-S3Object -BucketName text-content -Key aws-tech-docs

# Copy info to CSV for offline use

$BB_Host = $env:computername | Export-Csv C:\Temp\blubracket_copy.csv
$BB_Buckets = Get-S3Object -BucketName text-content -Key aws-tech-docs | Export-Csv c:\Temp\blubracket_copy1.csv

Show-EventLog 

Show-StorageHistory

Sync-Patch

###########################################################################################
# Stop script logging - Copies for historical records
###########################################################################################

Write-Host ""
$fileext = get-date -Format hh.mm.ss
Copy-Item -Path C:\Temp\VM_Tasks.log -Destination C:\Temp\VM_Tasks_$fileext.log
Stop-Transcript