###########################################################################################
# Name: BluBracket POC Test PS Script
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

$Datacticspocbb1_Variable1 = @()
$Datacticspoc1_Variable2 = @()

###########################################################################################
# Run Script
###########################################################################################

Copy-Item -Path C:\datacticspoc1.ini -Destination C:\datacticspoc1.bak

Copy-Item -Filter *.txt -Path c:\poc1bfs -Recurse -Destination C:\poc1bfs\datactics

$Computers = Get-Content -Path C:\bbpoc1\datacticspocbb1.txt

###########################################################################################
# Stop script logging - Copies for historical records
###########################################################################################

Write-Host ""
$fileext = get-date -Format hh.mm.ss
Copy-Item -Path C:\Temp\VM_Tasks.log -Destination C:\Temp\VM_Tasks_$fileext.log
Stop-Transcript