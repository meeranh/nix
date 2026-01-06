#!/bin/bash
# Switch workspace based on focused output
# Laptop (eDP-1): workspaces 1-10
# HDMI (HDMI-A-2): workspaces 11-20

NUM=$1

focused_output=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name')

if [ "$focused_output" = "HDMI-A-2" ]; then
    ws=$((NUM + 10))
else
    ws=$NUM
fi

swaymsg workspace $ws
