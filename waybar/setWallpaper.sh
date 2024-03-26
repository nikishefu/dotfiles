#!/bin/bash

swww img $1
cd /home/$USER/.config/waybar/
convert $1 \
    -blur 0x8 \
    -resize 1536x864 \
    -crop 1536x32+0+0 \
    -channel RGB \
    -brightness-contrast -20x-25 \
    background.png
killall waybar
waybar & disown
