#!/usr/bin/env bash

# Requirements:
# bemenu https://github.com/Cloudef/bemenu
# swaylock https://github.com/swaywm/swaylock

case $(
	bemenu --no-exec --prompt="power" <<EOF
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
