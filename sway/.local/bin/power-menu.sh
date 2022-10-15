#!/usr/bin/env bash

case $(
  bemenu --no-exec --prompt="power" <<EOF | sed 's/^ *//'
Shutdown
Reboot
Suspend
Hibernate
Logout
Lock
EOF
) in
"Shutdown")
  systemctl poweroff
  ;;
"Reboot")
  systemctl reboot
  ;;
"Suspend")
  swaylock && systemctl suspend
  ;;
"Hibernate")
  swaylock && systemctl hibernate
  ;;
"Logout")
  swaymsg exit
  ;;
"Lock")
  swaylock
  ;;
esac
