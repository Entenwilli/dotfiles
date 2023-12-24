#!/bin/bash

ctl=/usr/bin/pamixer
lockfile=~/.config/i3/scripts/volume-lockfile
iconDir="/usr/share/icons/Papirus-Dark/48x48/status"

while [ -f "$lockfile" ]; do
    sleep 0.1;
done
touch "$lockfile"


getIcon() {
    vol=$("$ctl" --get-volume)
    mute=$("$ctl" --get-mute)
    #echo $vol

    if [ "$mute" == "true" ]; then
        echo "$iconDir/notification-audio-volume-muted.svg"
    else
        if [ "$vol" -lt 33 ]; then
            echo "$iconDir/notification-audio-volume-low.svg"
        elif [ "$vol" -lt 66 ]; then
            echo "$iconDir/notification-audio-volume-medium.svg"
        else
            echo "$iconDir/notification-audio-volume-high.svg"
        fi
    fi
}



val="5"
orig=$("$ctl" --get-volume)
subinc=5


if [ "$1" == "mute" ]; then
    opt="--toggle-mute"
    "$ctl" "$opt"
else
    if [ "$1" == "inc" ]; then
        opt="--increase"
        if [ "$2" != '' ]; then val="$2"; fi

    elif [ "$1" == "dec" ]; then
        opt="--decrease"
        if [ "$2" != '' ]; then val="$2"; fi

    fi
    
    "$ctl" "$opt" "$val" &
    
    # Fake the animated volume
    for i in $(seq "$val"); do
        operation="+"
        inverse="-"
        if [ "$1" == "dec" ]; then
            operation="-"
            inverse="+"
        fi

        current=$(( ($orig "$operation" $i) "$inverse" 1 ))
        if [ "$current" -lt 0 ]; then
            current=0
            rm "$lockfile"
            exit 1
        fi

        mute=$("$ctl" --get-mute)
        ntext="Volume at $current%"
        if [ "$mute" == "true" ]; then
            ntext="Volume muted"
        fi

        dunstify -i "$(getIcon)" -u normal -h string:x-dunst-stack-tag:volume -a "Speaker" "$ntext" -h "int:value:${current}"
    done

fi

current=$("$ctl" --get-volume)
mute=$("$ctl" --get-mute)
ntext="Volume at $current%"

if [ "$mute" == "true" ]; then
    ntext="Volume muted"
fi

dunstify -i "$(getIcon)" -u normal -h string:x-dunst-stack-tag:volume -a "Speaker" "$ntext" -h "int:value:${current}"


rm "$lockfile"
