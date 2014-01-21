#!/bin/bash

echo Tap0 client disconnected.

ip addr del 10.10.10.1/24 dev tap0 scope link
ifenslave -d bond0 tap0

