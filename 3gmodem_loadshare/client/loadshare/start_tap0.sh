#!/bin/bash

ppp_ip0=`ip addr show ppp0 | grep inet | awk '{ print $2 }'`
ppp_pip0=`ip addr show ppp0 | grep inet | awk '{ print $4 }'`
ppp_gwip0=`ipcalc "$ppp_pip0" | grep Address | awk '{ print $2 }'`

echo "$ppp_ip0 $ppp_pip0 $ppp_gwip0"

ip route add "$ppp_gwip0" dev ppp0 src "$ppp_ip0" scope link table 100
ip route add default via "$ppp_gwip0" dev ppp0 table 100
ip rule add from "$ppp_ip0" table 100 prio 20000

tunctl -d tap0

openvpn --config /etc/loadshare/client1.conf --local "$ppp_ip0" --script-security 2 --up /etc/loadshare/entap0.sh &
 
