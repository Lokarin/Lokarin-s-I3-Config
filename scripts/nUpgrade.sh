#!/bin/bash

case $BLOCK_BUTTON in
	1) notify-send "$(apt list --upgradable 2>/dev/null | sed '1d' | awk '{print $1 }')" ;;
	#2) echo "Botão esquerdo" ;;
esac

apt list --upgradable 2>/dev/null | sed '1d' | wc - | awk '{ print $1 }'
