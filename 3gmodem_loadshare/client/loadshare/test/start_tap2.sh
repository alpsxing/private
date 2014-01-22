#!/bin/bash

ppp_ip0=`ip addr show ppp0 | grep inet | awk '{ print $2 }'`
ppp_pip0=`ip addr show ppp0 | grep inet | awk '{ print $4 }'`
ppp_gwip0=`ipcalc "$ppp_pip0" | grep Address | awk '{ print $2 }'`

echo "$ppp_ip0 $ppp_pip0 $ppp_gwip0"

ip route add "$ppp_gwip0" dev ppp0 src "$ppp_ip0" scope link table 102
ip route add default via "$ppp_gwip0" dev ppp0 table 102
ip rule add from "$ppp_ip0" table 102 prio 20002

tunctl -d tap2

openvpn --config /etc/loadshare/client3.conf --local "$ppp_ip0" --script-security 2 --up /etc/loadshare/test/entap2.sh --down /etc/loadshare/test/detap2.sh --up-restart
 
