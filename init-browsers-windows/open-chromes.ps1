# Prompt the user for the number of tabs to open
$numTabs = Read-Host "Enter the number of windows to open"

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