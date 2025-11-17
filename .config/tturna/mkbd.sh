#! /usr/bin/zsh

# check if on laptop
hostnamectl chassis | grep -q "laptop" > /dev/null

if [[ $? == 0 ]] then
    # on laptop
    xinput --set-prop 13 190 1.5 0 0 0 1.5 0 0 0 1

    # natural scrolling
    xinput --set-prop 13 320 1
else
    # on desktop
    xinput --set-prop 15 147 1.5 0 0 0 1.5 0 0 0 1
fi
