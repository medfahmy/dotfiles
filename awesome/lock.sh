#!/bin/bash

rm /tmp/blurred.png /tmp/screenshot.jpg
scrot -b '/tmp/screenshot.jpg'
convert /tmp/screenshot.jpg -blur 20x10 /tmp/blurred.png

# Put on-image.png on blurred.png
# composite -gravity center ~/media/arch.png blurred.png final.png

# Run i3lock
i3lock -i /tmp/blurred.png -d -I 30
