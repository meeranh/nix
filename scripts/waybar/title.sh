#!/usr/bin/env bash
# Output initial state
title=$(playerctl metadata --format '{{trunc(title,30)}}' 2>/dev/null)
if [ -n "$title" ]; then
    echo "$title"
else
    echo "Not Playing"
fi

# Follow for updates
playerctl metadata --follow --format '{{trunc(title,30)}}' 2>/dev/null | while read -r title; do
    if [ -n "$title" ]; then
        echo "$title"
    else
        echo "Not Playing"
    fi
done
