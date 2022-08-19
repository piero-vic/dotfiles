#!/usr/bin/env bash

device="${2:-intel_backlight}"

get_brightness() {
  brightnessctl -d "$device" | tr ' ' '\n' | grep '%' | tr -d '()'
}

notify() {
  if [[ "$device" = 'intel_backlight' ]]; then
    notify-send " Screen" "Brightness: $(get_brightness)"
  elif [[ "$device" = 'smc::kbd_backlight' ]]; then
    notify-send " Keyboard" "Brightness: $(get_brightness)"
  fi
}

inc_brightness() {
  brightnessctl -d "$device" -q set +5% && notify
}

dec_brightness() {
  brightnessctl -d "$device" -q set 5%- && notify
}

show_help() {
  cat <<EOF
Usage: brightness.sh [options] [device]
AVAILABLE OPTIONS:
  --inc         increase brightness by +5%
  --dec         decrease brightness by -5%
EOF
}

if [[ "$1" == "--inc" ]]; then
  inc_brightness
elif [[ "$1" == "--dec" ]]; then
  dec_brightness
else
  show_help
fi
