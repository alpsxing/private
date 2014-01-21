#!/bin/bash

ifconfig tap0 down
tunctl -u root -g root -t tap0
ifconfig tap0 up

openvpn --config /etc/loadshare/server1.conf --keepalive 10 30 --script-security 2 --client-connect entap0.sh --client-disconnect detap0.sh

sleep 10

ip addr add 10.10.10.1/24 dev tap0 scope link


