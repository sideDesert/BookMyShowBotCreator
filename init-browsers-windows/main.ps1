# Modify the path to the Chrome executable to match the installation path on your system
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope Process -Force

$chromeExePath = "C:\Program Files\Google\Chrome\Application\chrome.exe"

# Clear the chrome-profiles directory
$chromeProfilesDir = "$HOME\chrome-profiles"
$chromeProfile0Dir = "$chromeProfilesDir\0"
if (-not (Test-Path $chromeProfilesDir)) {
    New-Item -ItemType Directory -Path $chromeProfilesDir | Out-Null
}
Remove-Item -Recurse "$chromeProfilesDir\*" -Exclude $chromeProfile0Dir

# Create the 0 profile directory if it does not exist
$chromeProfile0Dir = "$chromeProfilesDir\0"
if (-not (Test-Path $chromeProfile0Dir)) {
    Start-Process $chromeExePath -ArgumentList "--user-data-dir=`"$chromeProfile0Dir`"" -Wait
}

$numTabs = Read-Host "Enter the number of windows to open"

# Create 50 additional profiles
Write-Host "Creating $numTabs profiles..."
for ($i = 1; $i -le $numTabs; $i++) {
    if (-not (Test-Path $chromeProfile0Dir)) {
        Start-Process $chromeExePath -ArgumentList "--user-data-dir=`"$chromeProfile0Dir`"" -Wait
    }
    Copy-Item -Recurse $chromeProfile0Dir "$chromeProfilesDir\$i"
    Write-Host "Created profile $i"
}

# Prompt the user for the URLs to open
$urls = @()
do {
    $url = Read-Host "Enter a URL to open"
    $urls += $url
    $moreUrls = Read-Host "Do you want to enter another URL? (Y/N)"
} while ($moreUrls -eq "Y" -or $moreUrls -eq "y")

# Open the URLs in Chrome
for ($i = 1; $i -le $numTabs; $i++) {
    for ($j = 0; $j -lt $urls.Length; $j++) {
        $chromeProfileDir = "$env:USERPROFILE\chrome-profiles\$i"
        if (-not (Test-Path $chromeProfileDir)) {
            New-Item -ItemType Directory -Path $chromeProfileDir | Out-Null
        }
        & "C:\Program Files\Google\Chrome\Application\chrome.exe" --user-data-dir="$chromeProfileDir" $urls[$j]
    }
}