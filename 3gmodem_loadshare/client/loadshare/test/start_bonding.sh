#!/bin/bash

while true; do
    ip route | grep "^default"
    if [ $? -eq 0 ]; then
        ip route del default
    else
        break
    fi
done

modprobe bonding mode=0 miimon=100
modprobe tun

sleep 5

ifconfig bond0 10.10.0.2 netmask 255.255.255.252 broadcast 10.10.0.3 up
ip route add default via 10.10.0.1 dev bond0

