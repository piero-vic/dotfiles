#!/usr/bin/env bash

script_name=${0}
current_pid=$$
previous_pid=$(ps -ef | grep "bash $script_name" | awk 'NR==1{print $2}')

if [[ "$current_pid" != "$previous_pid" ]]; then
	kill -9 $previous_pid
fi

while [[ 0 -eq 0 ]]; do
	battery_status="$(cat /sys/class/power_supply/BAT0/status)"
	battery_charge=$(acpi -b | grep -P -o '[0-9]+(?=%)')

	if [[ $battery_status == 'Discharging' && $battery_charge -le 15 ]]; then
		notify-send -u critical -t 31000 "Low Battery!" "Battery level is ${battery_charge}%"
	fi

	sleep 30
done
