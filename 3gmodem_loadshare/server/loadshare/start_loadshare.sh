#!/bin/bash

modprobe bonding mode=0 miimon=100 use_carrier=0 arp_interval=20 arp_ip_target=10.10.0.2
modprobe tun

ifconfig tap0 down
ifconfig tap1 down
ifconfig tap2 down

sleep 5

tunctl -u root -g root -t tap0
tunctl -u root -g root -t tap1
tunctl -u root -g root -t tap2

ifconfig tap0 up
ifconfig tap1 up
ifconfig tap2 up

sleep 5

ifconfig bond0 10.10.0.1 netmask 255.255.255.252 broadcast 10.10.0.3 up

openvpn --config /etc/loadshare/server1.conf --keepalive 10 30 --script-security 2 --client-connect /etc/loadshare/entap0.sh --client-disconnect /etc/loadshare/detap0.sh &
openvpn --config /etc/loadshare/server2.conf --keepalive 10 30 --script-security 2 --client-connect /etc/loadshare/entap1.sh --client-disconnect /etc/loadshare/detap1.sh &
openvpn --config /etc/loadshare/server3.conf --keepalive 10 30 --script-security 2 --client-connect /etc/loadshare/entap2.sh --client-disconnect /etc/loadshare/detap2.sh &
#sleep 10

#ifconfig bond0 10.10.0.1 netmask 255.255.255.252 broadcast 10.10.0.3 up

#ifenslave bond0 tap0 tap1 tap2

#ip addr add 10.10.10.1/24 dev tap0 scope link
#ip addr add 10.10.11.1/24 dev tap1 scope link
#ip addr add 10.10.12.1/24 dev tap2 scope link

