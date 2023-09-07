# Modify the path to the Chrome executable to match the installation path on your system
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope Process -Force

$chromeExePath = "C:\Program Files\Google\Chrome\Application\chrome.exe"

# Clear the chrome-profiles directory
Remove-Item -Recurse "$chromeProfilesDir\*" -Exclude $chromeProfile0Dir

# Create the 0 profile directory if it does not exist
$chromeProfile0Dir = "$chromeProfilesDir\0"
if (-not (Test-Path $chromeProfile0Dir)) {
    Start-Process $chromeExePath -ArgumentList "--user-data-dir=`"$chromeProfile0Dir`"" -Wait
}


# Create 50 additional profiles
for ($i = 1; $i -le 50; $i++) {
    if (-not (Test-Path $chromeProfile0Dir)) {
        Start-Process $chromeExePath -ArgumentList "--user-data-dir=`"$chromeProfile0Dir`"" -Wait
    }
    Copy-Item -Recurse $chromeProfile0Dir "$chromeProfilesDir\$i"
}