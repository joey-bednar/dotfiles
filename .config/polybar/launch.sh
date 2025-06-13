#!/usr/bin/env bash

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use 
# polybar-msg cmd quit
# Otherwise you can use the nuclear option:
killall -q polybar


# Get network interfaces for WiFi/Ethernet polybar module

# network interface used to reach Google public DNS (8.8.8.8)
interface=$(ip route get 8.8.8.8 2>/dev/null | awk '{for(i=1;i<=NF;i++) if ($i=="dev") print $(i+1); exit}')

# WiFi
if [[ -n ${interface} && ${interface:0:1} == "w" ]]; then
    export POLY_WIFI="${interface}"
# Ethernet
elif [[ -n ${interface} && ${interface:0:1} == "e" ]]; then
    export POLY_ETH="${interface}"
# Network with other name format, assume it is Ethernet
elif [[ -n ${interface} ]]; then
    export POLY_ETH="${interface}"
fi

# Get number of connected monitors
NUM_MONITORS=$(xrandr | grep -c " connected ")

# Launch bar on primary monitor
echo "---" | tee -a /tmp/polybar1.log
polybar primary -c "${HOME}/.config/polybar/config.ini" 2>&1 | tee -a /tmp/polybar1.log & disown

# Launch bar on secondary monitor
if [[ "$NUM_MONITORS" -gt "1" ]]; then
    echo "---" | tee -a /tmp/polybar2.log
    polybar secondary -c "${HOME}/.config/polybar/config.ini" 2>&1 | tee -a /tmp/polybar2.log & disown
fi

echo "Bars launched..."
