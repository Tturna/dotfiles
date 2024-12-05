#!/usr/bin/zsh

hostnamectl chassis | grep -q "laptop" > /dev/null

if [[ $? == 0 ]] then
    # on laptop
    IMG=/usr/share/endeavouros/backgrounds/Endy_vector_EOS-planet.png
else
    IMG=/usr/share/endeavouros/backgrounds/tturna/midjourney_biomechanical_heart.png
fi

feh --bg-fill $IMG
