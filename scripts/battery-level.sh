#!/bin/bash

# Set path for running in a cron job
PATH='/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/usr/local/go/bin:/home/kai/.local/bin'

# Set limit to shell argument
batteryLimit=20

battery=$(ls /sys/class/power_supply | grep BAT | head -n 1)
percentage=$(cat /sys/class/power_supply/${battery}/capacity)
state=$(cat /sys/class/power_supply/${battery}/status)

dunstify "Testing" -u critical

if [[ "$percentage" -le "$batteryLimit" ]] && [[ "$state" == "Discharging" ]]; then
    dunstify -a "Power Warning" -u critical "Battery level at ${percentage}%" -i battery -h string:x-dunst-stack-tag:battery
fi
