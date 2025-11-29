#!/usr/bin/env bash

case "$1" in
dark) sed -i 's/kanagawa_lotus/kanagawa_dragon/g' "$HOME/.config/alacritty/alacritty.toml" ;;
light) sed -i 's/kanagawa_dragon/kanagawa_lotus/g' "$HOME/.config/alacritty/alacritty.toml" ;;
default) exit 1 ;;
esac
