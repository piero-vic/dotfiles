#!/usr/bin/env bash

while [[ 0 -eq 0 ]]; do
  battery_status="$(cat /sys/class/power_supply/BAT0/status)"
  battery_charge=$(acpi -b | grep -P -o '[0-9]+(?=%)')
  echo $battery_status \| $battery_charge \| $(date '+%X')

  if [[ $battery_status == 'Discharging' && $battery_charge -le 15 ]]; then
    notify-send -u critical -t 31000 "Low Battery!" "Battery level is ${battery_charge}%"
  fi

  sleep 30
done
