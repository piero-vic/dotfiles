#!/bin/sh

gnome_schema="org.gnome.desktop.interface"

gsettings set $gnome_schema gtk-theme 'Adwaita'
gsettings set $gnome_schema icon-theme 'Papirus-Light'
gsettings set $gnome_schema font-name 'JetBrainsMono Nerd Font Mono Medium 9'
gsettings set $gnome_schema color-scheme 'prefer-light'
