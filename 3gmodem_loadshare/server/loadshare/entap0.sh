#!/bin/bash

echo Tap0 client connected.
ifenslave bond0 tap0

ip addr add 10.10.10.1/24 dev tap0 scope link

