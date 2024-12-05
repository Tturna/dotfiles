#!/usr/bin/zsh

polybar-msg cmd quit
polybar main & disown

hostnamectl chassis | grep -q "laptop" > /dev/null

# if not laptop, start bars on all desktop displays
if [[ $? != 0 ]] then
    polybar left & disown
    polybar right & disown
fi
