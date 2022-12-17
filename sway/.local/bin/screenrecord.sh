#!/usr/bin/env bash

# Setup
output_off="{\"text\": \"<span color='#aaaaaa'></span>\", \"tooltip\": \"Not recording\", \"alt\": \"\", \"class\": \"\" }"
output_rec="{\"text\": \"<span color='#c34043'></span>\", \"tooltip\": \"Recording\", \"alt\": \"\", \"class\": \"\" }"
recordings_directory=~/videos/screenrecordings
filename="$recordings_directory/$(date '+%Y%m%d_%Hh%Mm%Ss')_recording.mp4"
[[ -d $recordings_directory ]] || mkdir -p $recordings_directory

if pidof wf-recorder >/dev/null 2>&1; then
  if [[ "$1" == "toggle" ]]; then
    killall -s SIGINT wf-recorder >/dev/null 2>&1
    notify-send -a screenrecorder -t 1000 ' Screen recording' "Screen recording was stopped!"
    echo -n "$output_off"
    exit 0
  fi
  echo -n "$output_rec"
  exit 0
else
  if [[ "$1" == "toggle" ]]; then
    count=5

    while [[ $count -gt 1 ]]; do
      notify-send -a screenrecorder -t 1100 ' Screen recording' "Screen recording stars in $count"
      ((count -= 1 ))
      sleep 1
    done

    notify-send -a screenrecorder -t 1000 ' Screen recording' "Screen recording stars in 1"
    sleep 1

    wf-recorder -f "$filename" >/dev/null 2>&1 &
    echo -n "$output_rec"
    exit 0
  fi
  echo -n "$output_off"
  exit 0
fi
