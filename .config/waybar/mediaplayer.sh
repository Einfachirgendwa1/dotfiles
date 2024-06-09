#!/bin/sh
player_status=$(playerctl status 2>/dev/null)
if [ "$player_status" = "Playing" ]; then
	playerctl metadata title
elif [ "$player_status" = "Paused" ]; then
	echo " $(playerctl metadata title)"
fi
