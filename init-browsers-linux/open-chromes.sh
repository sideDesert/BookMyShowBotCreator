#!/bin/bash


read -p "Enter the number of windows to open: " num_tabs
read -p "Enter the URLs to open (separated by spaces): " urls

IFS=' ' read -ra urls_array <<< "$urls"

for i in $(seq 1 $num_tabs)
do
    for url in "${urls_array[@]}"
    do
        google-chrome --user-data-dir="$HOME/chrome-profiles/${i}" "$url" &
  done
done


