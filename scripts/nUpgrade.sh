#!/bin/bash

case $BLOCK_BUTTON in
	1) notify-send "$(apt list --upgradable 2>/dev/null | sed '1d' | awk '{print $1 }')" ;;
	#2) echo "Botão esquerdo" ;;
esac


packages=$(apt list --upgradable 2>/dev/null | sed '1d' | wc - | awk '{ print $1 }')
npackages="$packages"
color=$(xrdb -query | grep '*color2'| awk '{print $NF}')
white="#ededed"

if [ "$npackages" -ge 1 ]; then
	echo "<span foreground=\""$color"\">"$npackages"</span>"

else	
	echo "<span foreground=\""$white"\">"$npackages"</span>"
fi
