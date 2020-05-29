#!/bin/bash

. "${HOME}/.cache/wal/colors.sh"

man -k . | dmenu -c -l 20 -h 26 -nb "$color0" -nf "$color15" -sb "$color1" -sf "$color15" | awk '{print $1}' | xargs -r man -Tps | zathura -

