#!/usr/bin/env bash

gnome_schema="org.gnome.desktop.interface"

case "$1" in
dark)
  theme="Adwaita-dark"
  icon="Papirus-Dark"
  scheme="prefer-dark"
  ;;
light)
  theme="Adwaita"
  icon="Papirus-Light"
  scheme="prefer-light"
  ;;
default) exit 1 ;;
esac

gsettings set $gnome_schema gtk-theme "$theme"
gsettings set $gnome_schema icon-theme "$icon"
gsettings set $gnome_schema font-name "JetBrainsMono Nerd Font Mono Medium 9"
gsettings set $gnome_schema color-scheme "$scheme"
