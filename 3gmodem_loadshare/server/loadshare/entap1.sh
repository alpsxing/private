#!/bin/bash

echo Tap1 client connected.
ifenslave bond0 tap1

ip addr add 10.10.11.1/24 dev tap1 scope link

