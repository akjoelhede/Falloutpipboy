#!/bin/bash

# Get the primary display
primary_display=$(xrandr --listmonitors | grep "primary" | awk '{print $4}')

# Check if the primary display is available
if [ -n "$primary_display" ]; then
    echo "Primary display found at $primary_display"
    # Run your commands here, for example:
    DISPLAY=$primary_display cool-retro-term --fullscreen --noclose -e bash $HOME/Fallout3Terminal/terminalscript
else
    echo "Primary display not found."
    # Handle the case when primary display is not available
fi
