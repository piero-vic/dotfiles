#!/usr/bin/env bash

volume_up() {
  pamixer --unmute
  pamixer -i 5
  notify-send " Sound" "Volume: $(pamixer --get-volume)%"
}

volume_down() {
  pamixer --unmute
  pamixer -d 5
  notify-send " Sound" "Volume: $(pamixer --get-volume)%"
}

mute() {
  pamixer --toggle-mute
  if [[ $(pamixer --get-mute) = false ]]; then
    notify-send " Sound" "Volume: $(pamixer --get-volume)%"
  else
    notify-send " Sound" "Muted"
  fi
}

show_help() {
  cat <<EOF
Usage: volume.sh [options]
AVAILABLE OPTIONS:
  --inc            increase current volume by +5%
  --dec            decrease current volume by -5%
  --mute           mute audio
EOF
}

if [[ "$1" == "--inc" ]]; then
  volume_up
elif [[ "$1" == "--dec" ]]; then
  volume_down
elif [[ "$1" == "--mute" ]]; then
  mute
else
  show_help
fi
