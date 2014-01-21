#!/bin/bash

ppp_ip0="$1"
ppp_gwip0="$2"

PSNUMBER=`ps -aef | grep  "openvpn --config /etc/loadshare/client2.conf" | sed -n '1p' | awk '{ print $2 }'`
if [ -n ${PSNUMBER} ]; then
    logger LOADSHARE TAP1 DOWN ${PSNUMBER}
    kill ${PSNUMBER}
fi

ip route flush table 101
ip addr del 10.45.47.2/24 dev tap0
ifenslave -d bond0 tap1
tunctl -d tap1

