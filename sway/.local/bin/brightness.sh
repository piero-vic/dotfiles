#!/usr/bin/env bash

wobsock=$XDG_RUNTIME_DIR/wob.sock
device="${2:-intel_backlight}"

inc_brightness() {
  brightnessctl -d "$device" set +5% | sed -En 's/.*\(([0-9]+)%\).*/\1/p' >"$wobsock"
}

dec_brightness() {
  brightnessctl -d "$device" set 5%- | sed -En 's/.*\(([0-9]+)%\).*/\1/p' >"$wobsock"
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
