#!/usr/bin/env bash
dunstify "🔴 Recording started"
wf-recorder -f ~/media/screenrecords/$(date +%F_%T).mp4
