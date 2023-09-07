#!/bin/bash

# to
rm -r $HOME/chrome-profiles/*
google-chrome --user-data-dir="$HOME/chrome-profiles/0"

for i in {1..50}
    do
        #mkdir /home/siddarth/chrome-profiles/${i}
        cp -r "$HOME/chrome-profiles/0" "$HOME/chrome-profiles/${i}"
done
