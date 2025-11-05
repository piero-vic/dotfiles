#!/bin/sh

wallpaper="$HOME/.local/share/wallpapers/kanagawa_lotus.png"

background='#f2ecbc'
foreground='#545464'
border='#e7dba0'

green='#6f894e'
yellow='#77713f'
blue='#4d699b'

# Window decoration
# class                         border  backgr      text        indic   child_b
swaymsg client.focused          $blue   $blue       $background $green  $blue
swaymsg client.focused_inactive $border $border     $foreground $border $border
swaymsg client.unfocused        $border $background $foreground $border $border
swaymsg client.urgent           $yellow $yellow     $background $yellow $yellow

swaymsg output "*" bg "$wallpaper" fill
