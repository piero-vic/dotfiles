#!/usr/bin/env bash

screenshots_directory=~/pictures/screenshots
filename="$screenshots_directory/$(date '+%Y%m%d_%Hh%Mm%Ss')_grim.png"

[[ -d $screenshots_directory ]] || mkdir -p $screenshots_directory

send_notification() {
	notify-send -i "$filename" "󰄀 Grim" "Screenshot saved"
}

get_screen() {
	grim "$filename" && send_notification
}

get_window() {
	grim -g "$(swaymsg -t get_tree | jq -r '.. | select(.focused?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"')" "$filename" &&
		send_notification
}

get_section() {
	slurp_output="$(slurp 2>&1)"
	if [[ "$slurp_output" == "selection cancelled" ]]; then
		notify-send "󰄀 Grim" "Selection cancelled"
	else
		grim -g "$slurp_output" "$filename" && send_notification
	fi
}

case $(
	bemenu --no-exec --prompt="screencapture" <<EOF
Screen
Window
Selection
Record
EOF
) in
"Screen")
	get_screen
	;;
"Window")
	get_window
	;;
"Selection")
	get_section
	;;
"Record")
	screenrecord.sh toggle
	;;
esac
