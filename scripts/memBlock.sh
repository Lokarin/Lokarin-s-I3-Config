#!/bin/bash

case $BLOCK_BUTTON in
	1) notify-send "$(ps axch -o cmd:15,%mem --sort=-%mem | head)" ;;
	#2) echo "Right click action" ;;
esac

free -h | awk '/^Mem.:/ {print $3 "/" $2}'
