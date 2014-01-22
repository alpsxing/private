#!/bin/bash

echo Tap2 client connected.
ifenslave bond0 tap2

ip addr add 10.10.12.1/24 dev tap2 scope link

