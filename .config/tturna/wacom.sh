#! /usr/bin/bash

xsetwacom set 13 Mode Relative
xinput set-prop 13 147 0.4 0 0 0 0.4 0 0 0 1.0

# For Wacom Intuos S (Model CTL-4100), the buttons are A, B, C, and D from left to right
# Numbers 1, 2, and 3 seem to map to A, B, and C respectively. Button 4 didn't seem to work??
# This info can be found in /usr/share/libwacom/
xsetwacom set 14 Button 1 key "+ctrl +shift y -shift -ctrl"
