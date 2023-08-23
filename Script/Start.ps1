# Start the Script. 
# Read the files from XLS or CSV and convert to XML
# Check if the file we read is XLS or Csv
# If xls convert to CSV first and then to XML
$rootDir = Split-Path -Path $PSScriptRoot -Parent   

Import-Module "$rootDir\Functions\Functions_Excel_Csv.ps1" -Force
Import-Module "$rootDir\Functions\Functions_ToXML.ps1" -Force

#Create random users
write-host "Random users will be created... Please wait" -ForegroundColor Blue
create_randomUsers $rootDir
Wait-Event -Timeout 5

#Create the csv to XML
write-host "Convertion from csv to XML is going on now... Please wait" -ForegroundColor Blue
create_XML $rootDir | Out-Null
Wait-Event -Timeout 5

write-host "Add Users to AD fictive... Please wait" -ForegroundColor Blue
XML2ADUsers $rootDir