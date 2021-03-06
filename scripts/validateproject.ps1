# Sets current location to "validateproject.exe" folder
Set-Location "C:\tibco\designer\5.10\bin"

# Executes validateproject
# VERY IMPORTANT –  "-a" sets the alias library references. It's crucial for the #validation process
$tmp = .\validateproject.exe -a "C:\AnkitDrive\jenkins_ws\helloworld\FileAlias.properties" C:\AnkitDrive\github\tibcocicd\code\helloworld

# write output to console just for tracing
echo $tmp;

# This regex filters the number of errors
$regex = '[0-9]+ errors'
$output = select-string -InputObject $tmp -Pattern $regex -AllMatches | % {  $_.Matches } | % { $_.Value } | Out-String

# If regex output is NOT "0 errors" (that means that validation process has errors)
if($output -NotMatch "0 errors")
{
 # exit code 10 (If it's not 0, then Jenkins would fail the build)
 exit 10
}