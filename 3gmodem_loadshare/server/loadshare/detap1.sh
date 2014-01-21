#!/bin/bash

echo Tap1 client disconnected.

ip addr del 10.10.11.1/24 dev tap1 scope link
ifenslave -d bond0 tap1

