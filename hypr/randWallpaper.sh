#!/bin/bash
cd /home/nikita/Pictures
swww img $(ls | shuf -n 1) --transition-type center --transition-fps 50
