#!/usr/bin/zsh

polybar-msg cmd quit

hostnamectl chassis | grep -q "laptop" > /dev/null

if [[ $? != 0 ]] then
    # if not laptop, start bars on all desktop displays
    polybar left & disown
    polybar right & disown
else
    # if is laptop, define custom modules
    export POLYBAR_MODULES_RIGHT="cpu battery pulseaudio xkeyboard wlan date"
fi

polybar main & disown
