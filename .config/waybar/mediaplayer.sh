#!/bin/sh

player_status=$(playerctl status 2>&1)

if [ "$player_status" = "No players found" ]; then
	exit 1
fi

player_name=$(playerctl metadata | awk 'NR == 1 { print $1 }' 2>/dev/null)

if [ "$player_name" = "spotify" ]; then
	printf " "
elif [ "$player_name" = "firefox" ]; then
	printf "󰈹 "
fi

if [ "$player_status" = "Paused" ]; then
	printf " "
fi

printf " "
playerctl metadata title
exit 0
