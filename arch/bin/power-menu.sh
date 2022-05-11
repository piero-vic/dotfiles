#!/usr/bin/env bash

case $(
  wofi -d -l 2 -L 3 -w 2 <<EOF | sed 's/^ *//'
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
