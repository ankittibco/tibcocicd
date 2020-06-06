# Sets current location to "buildear.exe" folder
Set-Location "C:\Tibco\tra\5.10\bin"

# Executes BuildEar 
$tmp = .\buildear -a "C:\AnkitDrive\jenkins_ws\helloworld\FileAlias.properties" -x -v -s -ear ""/Deployment/helloworld.archive""  -o ""C:\AnkitDrive\jenkins_ws\helloworld\helloworld.ear"" -p ""C:\AnkitDrive\github\tibcocicd\code\helloworld""

# write output to console just for tracing
echo $tmp;

# Checks if "Ear created in:" (until line break) string is inside $tmp (output of buildear)
$regex = 'Ear created in:.*'
$output = select-string -InputObject $tmp -Pattern $regex -AllMatches | % {  $_.Matches } | % { $_.Value } | Out-String

# If output doesn't contain "Ear created in" then fail the build (exit code 10)
if($output -notlike "Ear created in:*")
{
 exit 10
}