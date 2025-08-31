#!/bin/sh

wallpaper="$HOME/.local/share/wallpapers/kanagawa_lotus.png"

background='#f2ecbc'
foreground='#545464'
border='#dcd7ba'

green='#6f894e'
yellow='#77713f'
blue='#4d699b'

# Window decoration
# class                         border  backgr      text        indic   child_b
swaymsg client.focused          $blue   $blue       $background $green  $blue
swaymsg client.focused_inactive $blue   $background $blue       $border $border
swaymsg client.unfocused        $blue   $background $foreground $border $border
swaymsg client.urgent           $yellow $yellow     $background $yellow $yellow

swaymsg output "*" bg "$wallpaper" fill
