#!/bin/bash
# Throw current window to mirror workspace on the other monitor
# Workspace 5 -> 15, Workspace 15 -> 5, etc.

current_ws=$(swaymsg -t get_workspaces | jq '.[] | select(.focused) | .num')

if [ "$current_ws" -le 10 ]; then
    # On laptop (1-10), move to HDMI mirror (+10)
    target_ws=$((current_ws + 10))
else
    # On HDMI (11-20), move to laptop mirror (-10)
    target_ws=$((current_ws - 10))
fi

# Move window to target workspace and follow focus
swaymsg move container to workspace $target_ws
swaymsg workspace $target_ws
