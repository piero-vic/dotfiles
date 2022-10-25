#!/usr/bin/env bash

# Setup
output_off="{\"text\": \"<span color='#aaaaaa'></span>\", \"tooltip\": \"Not recording\", \"alt\": \"\", \"class\": \"\" }"
output_rec="{\"text\": \"<span color='#c34043'></span>\", \"tooltip\": \"Recording\", \"alt\": \"\", \"class\": \"\" }"
recordings_directory=~/videos/screenrecordings
filename="$recordings_directory/$(date '+%Y%m%d_%Hh%Mm%Ss')_recording.mp4"
[[ -d $recordings_directory ]] || mkdir -p $recordings_directory

# Options
record_screen() {
  notify-send -a screenrecorder -t 3000 ' Screen recording' "Screen recording was started!"
  sleep 3
  wf-recorder -f "$filename" >/dev/null 2>&1 &
  echo -n "$output_rec"
  exit 0
}

record_window() {
  notify-send -a screenrecorder -t 3000 ' Screen recording' "Screen recording was started!"
  sleep 3
  wf-recorder -f "$filename" -g "$(swaymsg -t get_tree | jq -r '.. | select(.focused?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"')" >/dev/null 2>&1 &
  echo -n "$output_rec"
  exit 0
}

record_section() {
  slurp_output="$(slurp 2>&1)"
  if [[ "$slurp_output" == "selection cancelled" ]]; then
    notify-send " Screen recording" "Selection cancelled"
  else
    grim -g "$slurp_output" "$filename" && send_notification
    notify-send -a screenrecorder -t 3000 ' Screen recording' "Screen recording was started!"
    sleep 3
    wf-recorder -f "$filename" -g "$slurp_output" >/dev/null 2>&1 &
    echo -n "$output_rec"
    exit 0
  fi
}

# Run
if pidof wf-recorder >/dev/null 2>&1; then
  if [[ "$1" == "toggle" ]]; then
    killall -s SIGINT wf-recorder >/dev/null 2>&1
    notify-send -a screenrecorder -t 3000 ' Screen recording' "Screen recording was stopped!"
    echo -n "$output_off"
    exit 0
  fi
  echo -n "$output_rec"
  exit 0
else
  if [[ "$1" == "toggle" ]]; then
    case $(
      bemenu --no-exec --prompt="screenrecord" <<EOF | sed 's/^ *//'
(S)creen
(W)indow
(X)Section
EOF
    ) in
    "(S)creen")
      record_screen
      ;;
    "(W)indow")
      record_window
      ;;
    "(X)Section")
      record_section
      ;;
    esac
  fi
  echo -n "$output_off"
  exit 0
fi
