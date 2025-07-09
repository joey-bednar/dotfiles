#!/bin/bash

set -e

if ! command -v redshift >/dev/null; then
    exit
fi

if ! command -v xrandr >/dev/null; then
    exit
fi

# Redshift is running if monitor "Gamma" is different than the default "1.0:1.0:1.0"
__gamma_set() {
    if [[ "$(xrandr --verbose | grep -m 1 "Gamma:" | cut -d ":" -f2- | tr -d ' ')" == "1.0:1.0:1.0" ]]; then
        return 0
    fi
    return 1
}

# toggle redshift on/off
if [[ "$1" == "toggle" ]]; then
    if __gamma_set; then
        # set redshift brightness and temp
        redshift -P -b 0.7 -O 4000
    else
        # reset redshift settings
        redshift -x
    fi
fi

# display icon
if __gamma_set; then
    echo "󰌶"
else
    echo "󰌵"
fi

