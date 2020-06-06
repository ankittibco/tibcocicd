# Sets current location to "AppManage.exe" folder
Set-Location "C:\tibco\tra\5.10\bin"

# Deploy ear to development domain
$tmp = .\AppManage -user "admin" -pw "admin" -domain "AnkitLocal" -app "helloworld" -upload -ear "C:\AnkitDrive\jenkins_ws\helloworld\helloworld.ear"

# Write deploy output to console
echo $tmp;

# Check if deployment finished successfully
$regex = 'Finished successfully in.*'
$output = select-string -InputObject $tmp -Pattern $regex -AllMatches | % {  $_.Matches } | % { $_.Value } | Out-String

# If output doesn't contain "Finished successfully in" then fail the build (exit code 10)
if($output -notlike "Finished successfully in*")
{
 exit 10
               }