#!/bin/bash

ppp_ip0="$1"
ppp_gwip0="$2"
ppp_if="$3"

logger Start tap2  "$ppp_ip0 $ppp_gwip0"

ip route add "$ppp_gwip0" dev "$ppp_if" src "$ppp_ip0" scope link table 102
ip route add default via "$ppp_gwip0" dev "$ppp_if" table 102
ip rule add from "$ppp_ip0" table 102 prio 20002

tunctl -d tap2

openvpn --config /etc/loadshare/client3.conf --local "$ppp_ip0" --script-security 2 --up /etc/loadshare/entap2.sh --down /etc/loadshare/detap2.sh --up-restart&
 
