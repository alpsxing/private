#!/bin/bash

modprobe bonding mode=0 miimon=100 use_carrier=0 arp_interval=20 arp_ip_target=10.10.0.2
modprobe tun

ifconfig bond0 10.10.0.1 netmask 255.255.255.252 broadcast 10.10.0.3 up

