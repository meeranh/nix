#!/bin/bash
if pgrep -x wf-recorder > /dev/null; then
    if (( $(date +%s) % 2 )); then
        echo " /  <span color='@red@'>󰑊</span> "
    else
        echo " /  <span color='@red@'>󰻃</span> "
    fi
else
    echo ""
fi
