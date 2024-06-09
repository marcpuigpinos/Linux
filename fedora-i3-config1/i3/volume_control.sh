
#!/bin/bash

# Get the current volume level
current_vol=$(amixer sget Master | grep "Front Left:" | awk -F'[][]' '{print substr($2, 1, length($2)-1)}')

# If the volume is already at 100% or higher, set it to 100%
if [ "$current_vol" -ge 100 ]; then
    pactl set-sink-volume @DEFAULT_SINK@ 100%
else
    # If not, increase the volume by 2%
    pactl set-sink-volume @DEFAULT_SINK@ +2%
fi
