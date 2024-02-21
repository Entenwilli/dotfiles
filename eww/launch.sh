#!/bin/bash
/opt/bin/eww kill

echo "------- Reloading eww --------" | tee -a /tmp/eww.log

/opt/bin/eww open-many bar:primary bar:secondary --arg primary:monitor=0 --arg secondary:monitor=1 2>&1 | tee -a /tmp/eww.log & disown

