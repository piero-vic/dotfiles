#!/usr/bin/env bash

case "$1" in
dark) sed -i 's/kanagawa_lotus/kanagawa_dragon/g' "$HOME/.config/rofi/config.rasi" ;;
light) sed -i 's/kanagawa_dragon/kanagawa_lotus/g' "$HOME/.config/rofi/config.rasi" ;;
default) exit 1 ;;
esac
