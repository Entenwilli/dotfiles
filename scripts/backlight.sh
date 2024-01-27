#!/bin/bash

subinc=1
subchange=$(echo "1 / $subinc" | bc -l)
delay=0.001
opt=""


getIcon() {
    if [ "$1" -eq 0 ]; then
        echo "/usr/share/icons/Papirus-Dark/48x48/status/notification-display-brightness-off.svg"
    elif [ "$1" -lt 33 ]; then
        echo "/usr/share/icons/Papirus-Dark/48x48/status/notification-display-brightness-low.svg"
    elif [ "$1" -lt 66 ]; then
        echo "/usr/share/icons/Papirus-Dark/48x48/status/notification-display-brightness-medium.svg"
    else
        echo "/usr/share/icons/Papirus-Dark/48x48/status/notification-display-brightness-high.svg"
    fi

}


if [ "$1" == "inc" ]; then
    opt="+"
else
    opt="-"
fi


for i in $(seq $2); do
    current=$(brightnessctl -m -d intel_backlight | awk -F, '{print substr($4, 0, length($4)-1)}' | tr -d '%')
    truncated=$(echo "$current" | cut -d '.' -f1)

    if (( $(echo "$current==0" | bc -l) )) && [ "$opt" == "-U" ]; then
        exit 0;
    elif (( $(echo "$current==100" | bc -l) )) && [ "$opt" == "-A"  ]; then
        exit 0;
    fi

    for i in $(seq $subinc); do
        brightnessctl set "$subchange\%$opt"
        sleep "$delay"
    done
        
    current=$(brightnessctl -m -d intel_backlight | awk -F, '{print substr($4, 0, length($4)-1)}' | tr -d '%')
    truncated=$(echo "$current" | cut -d '.' -f1)

    
    dunstify "Brightness at ${truncated}%" -i $(getIcon "$truncated") -a "Backlight" -u normal -h "int:value:$current" -h string:x-dunst-stack-tag:backlight
done
