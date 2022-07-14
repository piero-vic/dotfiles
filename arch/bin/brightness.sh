#!/usr/bin/env bash

device="${2:-intel_backlight}"

get_brightness() {
  brightnessctl -d "$device" | tr ' ' '\n' | grep '%' | tr -d '()'
}

inc_brightness() {
  brightnessctl -d "$device" -q set +5%
  get_brightness
}

dec_brightness() {
  brightnessctl -d "$device" -q set 5%-
  get_brightness
}

show_help() {
  cat <<EOF
Usage: brightness.sh [options] [device]
AVAILABLE OPTIONS:
  --get         get current brightness
  --inc         increase current brightness by +5
  --dec         decrease current brightness by -5
EOF
}

if [[ "$1" == "--get" ]]; then
	get_brightness
elif [[ "$1" == "--inc" ]]; then
	inc_brightness
elif [[ "$1" == "--dec" ]]; then
	dec_brightness
else
	show_help
fi
