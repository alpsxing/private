#!/bin/bash

echo Tap2 client disconnected.

ip addr del 10.10.12.1/24 dev tap2 scope link
ifenslave -d bond0 tap2

