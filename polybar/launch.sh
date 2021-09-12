#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

# Launch bar1 and bar2
echo "---" | tee -a /tmp/polybar.log /tmp/polybar.log
# polybar example 2>&1 | tee -a /tmp/polybar.log & disown
polybar main 2>&1 | tee -a /tmp/polybar1.log & disown

echo "Bars launched..."


