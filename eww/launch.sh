#!/bin/bash
/opt/bin/eww kill

echo "------- Reloading eww --------" | tee -a /tmp/eww.log

/opt/bin/eww open bar 2>&1 | tee -a /tmp/eww.log & disown

