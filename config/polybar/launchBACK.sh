#1/usr/bin/bash

## Add this to your wm startup file.

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
#polybar example -r &

screens=$(xrandr --listactivemonitors | grep -v "Monitors" | cut -d" " -f6)

if [[ $(xrandr --listactivemonitors | grep -v "Monitors" | cut -d" " -f4 | cut -d"+" -f2- | uniq | wc -l) == 1 ]]; then
	MONITOR=$(polybar --list-monitors | cut -d":" -f1) polybar main & MONITOR=$(polybar --list-monitors | cut -d":" -f1) polybar tasks & MONITOR=$(polybar --list-monitors | cut -d":" -f1) polybar espaco & MONITOR=$(polybar --list-monitors | cut -d":" -f1) polybar cpu & MONITOR=$(polybar --list-monitors | cut -d":" -f1) polybar gpu & MONITOR=$(polybar --list-monitors | cut -d":" -f1) polybar pulseaudio &
else
  primary=$(xrandr --query | grep primary | cut -d" " -f1)

  for m in $screens; do
    if [[ $primary == $m ]]; then
        MONITOR=$m TRAY_POS=right polybar main &
    else
        MONITOR=$m TRAY_POS=none polybar secondary &
    fi
  done
fi
