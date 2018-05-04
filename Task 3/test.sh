#!/bin/bash
export DISPLAY=':0.0'
export XAUTHORITY="/home/username/.Xauthority"

startwid=$(xdotool getactivewindow)
curPath=$(pwd)
xdotool key "ctrl+alt+t"
sleep 1
vimwid=$(xdotool getactivewindow)
xdotool windowfocus $vimwid
xdotool type "cd $curPath"
xdotool key Return
sleep 0.5
xdotool type "rm testvim.txt"
xdotool key Return
sleep 0.5
xdotool type "vim testvim.txt"
xdotool key Return
sleep 0.5
xdotool key "shift+i"
sleep 0.5
xdotool type "Hello, world!"
sleep 0.5
xdotool key Escape
sleep 0.5
xdotool key "shift+colon"
sleep 0.5
xdotool type "wq"
sleep 0.5
xdotool key Return
sleep 0.5
xdotool windowfocus $startwid
res=$(cat testvim.txt)
rightRes="Hello, world!"
if [ "$res" == "$rightRes" ]
then
    echo "Vim works"
else
    echo "Vim doesn't work properly"
fi

xdotool windowfocus $vimwid
sleep 0.5
xdotool type "exit"
xdotool key Return

