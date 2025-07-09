#!/bin/bash

vpn="$(nmcli -t -f name,type connection show --order name --active 2>/dev/null | grep -i protonvpn | head -1 | cut -d ':' -f 1)"

if [ -n "$vpn" ]; then
    # echo server if using wireguard protonvpn.conf
    if [[ "$vpn" == "protonvpn" ]]; then
        echo "US-CA#706"
    else
        echo "$vpn" | cut -d ' ' -f 2
    fi
else
	echo "DOWN"
fi
