#!/usr/bin/env bash

# Requirements:
# pamixer https://github.com/cdemoulins/pamixer
# wob https://github.com/francma/wob

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

mic_mute() {
	pamixer --default-source --toggle-mute
}

show_help() {
	cat <<EOF
Usage: volume.sh [options]
AVAILABLE OPTIONS:
  --inc            increase current volume by +5%
  --dec            decrease current volume by -5%
  --mute           mute audio
  --mute-mic       mute microphone
EOF
}

if [[ "$1" == "--inc" ]]; then
	volume_up
elif [[ "$1" == "--dec" ]]; then
	volume_down
elif [[ "$1" == "--mute" ]]; then
	mute
elif [[ "$1" == "--mic-mute" ]]; then
	mic_mute
else
	show_help
fi
