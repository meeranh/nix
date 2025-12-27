#!/usr/bin/env bash
grim -g "$(slurp)" - | wl-copy
wl-paste -t image/png > ~/media/screenshots/$(date +%F_%T).png
dunstify "Screenshot captured"
