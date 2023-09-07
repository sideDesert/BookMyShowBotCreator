#!/bin/bash

# Prompt the user for the number of tabs to open
read -p "Enter the number of windows to open: " numTabs

# Prompt the user for the URLs to open
urls=()
while true; do
    read -p "Enter a URL to open: " url
    urls+=("$url")
    read -p "Do you want to enter another URL? (Y/N) " moreUrls
    if [[ $moreUrls != [yY] ]]; then
        break
    fi
done

# Create the Chrome profiles
echo "Creating Chrome profiles..."
for ((i = 1; i <= numTabs; i++)); do
    chromeProfileDir="$HOME/chrome-profiles/$i"
    mkdir -p "$chromeProfileDir"
done

# Open the URLs in Chrome
echo "Opening URLs in Chrome..."
for ((i = 1; i <= numTabs; i++)); do
    for url in "${urls[@]}"; do
        chromeProfileDir="$HOME/chrome-profiles/$i"
        "$chromeExePath" --user-data-dir="$chromeProfileDir" "$url" &
    done
done
