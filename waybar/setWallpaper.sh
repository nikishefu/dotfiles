#!/bin/bash

swww img $1
cd /home/$USER/.config/waybar/
convert $1 \
    -blur 0x8 \
    -crop 1920x32+0+0 \
    -channel RGB \
    -brightness-contrast -15x-25 \
    background.png
killall waybar
waybar & disown
