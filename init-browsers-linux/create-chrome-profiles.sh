#!/bin/bash

# Modify the path to the Chrome executable to match the installation path on your system
chromeExePath="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"

# Clear the chrome-profiles directory
chromeProfilesDir="$HOME/chrome-profiles"
if [ ! -d "$chromeProfilesDir" ]; then
    mkdir "$chromeProfilesDir"
fi
chromeProfile0Dir="$chromeProfilesDir/0"
rm -rf "$chromeProfilesDir"/*
mkdir -p "$chromeProfilesDir"

# Create the 0 profile directory if it does not exist
if [ ! -d "$chromeProfile0Dir" ]; then
    "$chromeExePath" --user-data-dir="$chromeProfile0Dir"
fi

# Create 50 additional profiles
echo "Creating 50 profiles..."
for i in {1..50}; do
    if [ ! -d "$chromeProfile0Dir" ]; then
        "$chromeExePath" --user-data-dir="$chromeProfile0Dir"
    fi
    cp -r "$chromeProfile0Dir" "$chromeProfilesDir/$i"
done
