#!/usr/bin/env bash

wobsock=$XDG_RUNTIME_DIR/wob.sock

volume_up() {
  pamixer -ui 5 && pamixer --get-volume >"$wobsock"
}

volume_down() {
  pamixer -ud 5 && pamixer --get-volume >"$wobsock"
}

mute() {
  pamixer --toggle-mute && ([ "$(pamixer --get-mute)" = "true" ] && echo 0 >"$wobsock") || pamixer --get-volume >"$wobsock"
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
