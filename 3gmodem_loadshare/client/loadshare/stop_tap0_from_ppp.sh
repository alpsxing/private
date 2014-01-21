#!/bin/bash

ppp_ip0="$1"
ppp_gwip0="$2"

PSNUMBER=`ps -aef | grep  "openvpn --config /etc/loadshare/client1.conf" | sed -n '1p' | awk '{ print $2 }'`
if [ -n ${PSNUMBER} ]; then
    logger LOADSHARE TAP0 DOWN ${PSNUMBER}
    kill ${PSNUMBER}
fi

ip route flush table 100
ip addr del 10.45.46.2/24 dev tap0
ifenslave -d bond0 tap0
tunctl -d tap0

