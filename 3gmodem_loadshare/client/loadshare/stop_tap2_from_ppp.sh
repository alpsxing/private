#!/bin/bash

ppp_ip0="$1"
ppp_gwip0="$2"

PSNUMBER=`ps -aef | grep  "openvpn --config /etc/loadshare/client3.conf" | sed -n '1p' | awk '{ print $2 }'`
if [ -n ${PSNUMBER} ]; then
    logger LOADSHARE TAP2 DOWN ${PSNUMBER}
    kill ${PSNUMBER}
fi

ip route flush table 102
ip addr del 10.45.48.2/24 dev tap2
ifenslave -d bond0 tap2
tunctl -d tap2

