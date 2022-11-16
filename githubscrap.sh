#!/bin/bash
while read line; do
    curl $line > output
    body=$(curl $line)
    tool=$(echo $line | cut -d "/" -f 5)
    link=$(echo $line|sed 's/\//\\\//g' )
    forks=$(cat output | sed 's/</\n/g' | grep repo-network-counter | cut -d ">" -f 2)
    stars=$(cat output | sed 's/</\n/g' | grep repo-stars-counter-star | cut -d ">" -f 2)
    repo=$(echo $line | cut -d "/" -f 4)
    curl $line | grep  'p class="f4 my-3">' -A 1 | tail -1 | sed 's/"/\\"/g'| sed "s/^/{\"tool\":\"$tool\",\"link\":\"$link\",\"description\":\"/g" | sed 's/      //g' | sed "s/$/\",\"forks\":\"$forks\",\"stars\":\"$stars\",\"tag\":\"$repo\"},/g" | sed 's/<g-emoji.*<\/g-emoji>//g'
    sleep 1
done < $1
