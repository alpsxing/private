#!/bin/bash

ppp_ip1="$1"
ppp_gwip1="$2"

echo "$ppp_ip1 $ppp_gwip1"

ip route add "$ppp_gwip1" dev ppp1 src "$ppp_ip1" scope link table 101
ip route add default via "$ppp_gwip1" dev ppp1 table 101
ip rule add from "$ppp_ip1" table 101 prio 20001

tunctl -d tap1

openvpn --config /etc/loadshare/client2.conf --local "$ppp_ip1" --script-security 2 --up /etc/loadshare/entap1.sh --down /etc/loadshare/detap1.sh --up-restart&
 
