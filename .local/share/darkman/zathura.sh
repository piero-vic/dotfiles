#!/usr/bin/env bash

case "$1" in
dark) sed -i 's/zathurarc-light/zathurarc-dark/g' "$HOME/.config/zathura/zathurarc" ;;
light) sed -i 's/zathurarc-dark/zathurarc-light/g' "$HOME/.config/zathura/zathurarc" ;;
default) exit 1 ;;
esac
