#!/usr/bin/env bash

case "$1" in
dark)
  wallpaper="$HOME/.local/share/wallpapers/kanagawa_dragon.png"
  background='#181616'
  foreground='#c5c9c5'
  border='#282727'
  green='#8a9a7b'
  yellow='#c4b28a'
  blue='#8ba4b0'
  ;;
light)
  wallpaper="$HOME/.local/share/wallpapers/kanagawa_lotus.png"
  background='#f2ecbc'
  foreground='#545464'
  border='#e7dba0'
  green='#6f894e'
  yellow='#77713f'
  blue='#4d699b'
  ;;
default) exit 1 ;;
esac

# Window decoration
# class                         border  backgr      text        indic   child_b
swaymsg client.focused          $blue   $blue       $background $green  $blue
swaymsg client.focused_inactive $border $border     $foreground $border $border
swaymsg client.unfocused        $border $background $foreground $border $border
swaymsg client.urgent           $yellow $yellow     $background $yellow $yellow

swaymsg output "*" bg "$wallpaper" fill
