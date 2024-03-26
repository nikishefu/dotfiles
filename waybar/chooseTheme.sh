#!/usr/bin/bash

themes=(/home/$USER/.config/waybar/themes/*)
echo $themes | nl -s '. ' -w 1
echo "Select theme"
read num
selected=$themes[$num]
echo "Selected theme is $selected"
cp $selected /home/$USER/.config/waybar/style.css
killall waybar
waybar &
