#!/bin/sh

wallpaper="$HOME/.local/share/wallpapers/kanagawa_dragon.png"

background='#181616'
foreground='#c5c9c5'
border='#282727'

green='#8a9a7b'
yellow='#c4b28a'
blue='#8ba4b0'

# Window decoration
# class                         border  backgr      text        indic   child_b
swaymsg client.focused          $blue   $blue       $background $green  $blue
swaymsg client.focused_inactive $blue   $background $blue       $border $border
swaymsg client.unfocused        $blue   $background $foreground $border $border
swaymsg client.urgent           $yellow $yellow     $background $yellow $yellow

swaymsg output "*" bg "$wallpaper" fill
