#!/bin/bash

ppp_ip0="$1"
ppp_gwip0="$2"
ppp_if="$3"

logger Start tap0  "$ppp_ip0 $ppp_gwip0"

ip route add "$ppp_gwip0" dev "$ppp_if" src "$ppp_ip0" scope link table 100
ip route add default via "$ppp_gwip0" dev "$ppp_if" table 100
ip rule add from "$ppp_ip0" table 100 prio 20000

tunctl -d tap0

openvpn --config /etc/loadshare/client1.conf --local "$ppp_ip0" --script-security 2 --up /etc/loadshare/entap0.sh --down /etc/loadshare/detap0.sh --up-restart&
 
