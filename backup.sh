#!/bin/bash

while [ -n "$1" ]
do
    case "$1" in
        -d) shift; dirName="$1";;
        -e) shift; expansions="$1";;
        -a) shift; archieveName="$1";;
        *) echo "Error: wrong key";;
    esac
    shift
done

homeDirectory="."

if ! [ -d $dirName ]; then
    mkdir &>/dev/null $dirName
fi


for exp in $expansions
do
    files=$(find 2>/dev/null $homeDirectory -type f -name "*.$exp")
    IFS=$'\n'
    for file in $files
    do
        name=$(echo "$file" | grep -oP "[^/]*$")
        num=0
        newName=$(echo "$dirName/$name")
        
        while [ -f $newName ]
        do
            num=$(($num+1))
            newName=$(echo "$dirName/$name($num)")
        done
        cp $file $newName
    done
done

tar &>/dev/null -czf $archieveName $dirName

echo "done"
