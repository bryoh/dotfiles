#!/bin/bash

# Specifying the icon(s) in the script
# This allows us to change its appearance conditionally
icon=""
player_color="%F{ffa419}"


player_status=$(playerctl status 2>&1 /dev/null)
if [[ $? -eq 0 ]]; then
    metadata=" $(playerctl metadata artist)  $(playerctl metadata album)   $(playerctl metadata title)"
    if [[ $(playerctl metadata) == *'spotify'* ]]; then
        player_color='%{F#1db954}'
    fi
fi

# Foreground color formatting tags are optional
if [[ $player_status = "Playing" ]]; then
    echo "%{F#$player_color$metadata"       # Orange when playing
elif [[ $player_status = "Paused" ]]; then
    echo "%{F#42321b}$metadata"       # Greyed out info when paused
else
    echo "%{F#A86C11}$icon"                 # Greyed out icon when stopped
fi
