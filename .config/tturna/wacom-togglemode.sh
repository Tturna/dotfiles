#! /usr/bin/bash

if xsetwacom get 13 Mode | grep -q "Relative"; then
    # mode is relative, set to absolute
    echo "setting to absolute";
    xsetwacom set 13 Mode Absolute;
    xinput set-prop 13 156 1.0 0 0 0 1.0 0 0 0 1.0;
    xsetwacom set 13 MapToOutput 1920x1080+1920+0;
else
    # mode is absolute, set to relative
    echo "setting to relative";
    xsetwacom set 13 MapToOutput desktop;
    /home/tturna/.config/tturna/wacom.sh;
fi

