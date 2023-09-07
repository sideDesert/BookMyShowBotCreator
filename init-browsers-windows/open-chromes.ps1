$numTabs = Read-Host "Enter the number of windows to open"
$urls = Read-Host "Enter the URLs to open (separated by spaces)"
$urlsArray = $urls.Split(" ")

for ($i = 1; $i -le $numTabs; $i++) {
    for ($j = 0; $j -lt $urlsArray.Length; $j++) {
        $chromeProfileDir = "$env:USERPROFILE\chrome-profiles\$i"
        if (-not (Test-Path $chromeProfileDir)) {
            New-Item -ItemType Directory -Path $chromeProfileDir | Out-Null
        }
        & "C:\Program Files\Google\Chrome\Application\chrome.exe" --user-data-dir="$chromeProfileDir" $urlsArray[$j]
    }
}