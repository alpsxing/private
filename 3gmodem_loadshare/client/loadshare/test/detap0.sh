#!/bin/bash

echo Tap0 down.
ip addr del 10.45.46.2/24 dev tap0
ifenslave -d bond0 tap0

