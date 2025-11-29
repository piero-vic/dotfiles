#!/usr/bin/env bash

pgrep mako || exit 1

case "$1" in
dark) other=light ;;
light) other=dark ;;
default) exit 1 ;;
esac

makoctl mode -a "$1" -r "$other"
