#!/usr/bin/env bash

# Requirements:
# mako https://github.com/emersion/mako

set -e

lock_file="/tmp/battery_monitor.lock"

if [[ -e "$lock_file" ]]; then
	echo "Another instance is already running. Exiting."
	exit 1
fi

touch "$lock_file"

remove_lock_file() {
	rm -f "$lock_file"
	exit 1
}

trap 'remove_lock_file' EXIT SIGINT SIGTERM

while true; do
	battery_status=$(cat /sys/class/power_supply/BAT0/status)
	battery_charge=$(cat /sys/class/power_supply/BAT0/capacity)

	if [[ $battery_status == 'Discharging' && $battery_charge -le 15 ]]; then
		notify-send -u critical -t 31000 "Low Battery!" "Battery level is ${battery_charge}%"
	fi

	sleep 30
done
