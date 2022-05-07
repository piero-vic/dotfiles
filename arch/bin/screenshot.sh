#!/usr/bin/env bash

screenshots_directory=~/Pictures/screenshots
filename="$screenshots_directory/$(date '+%Y%m%d_%Hh%Mm%Ss')_grim.png"

[[ -d $screenshots_directory ]] || mkdir -p $screenshots_directory

send_notification() {
	notify-send -i "$filename" " Grim" "Screenshot saved"
}

get_screen() {
	grim "$filename" && send_notification
}

get_window() {
	grim -g "$(swaymsg -t get_tree | jq -r '.. | select(.focused?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"')" "$filename" \
	&& send_notification
}

get_section() {
	slurp_output="$(slurp 2>&1)"
	if [[ "$slurp_output" == "selection cancelled" ]]; then
		notify-send " Grim" "Selection cancelled"
	else
		grim -g "$slurp_output" "$filename" && send_notification
	fi
}

show_help() {
	cat <<EOF
Usage: screenshot.sh [options]
AVAILABLE OPTIONS:
  --screen           grab the whole screen
  --window           grab the current window
  --section          grab a section of the screen
EOF
}

if [[ "$1" == "--screen" ]]; then
	get_screen
elif [[ "$1" == "--window" ]]; then
	get_window
elif [[ "$1" == "--section" ]]; then
	get_section
else
	show_help
fi
