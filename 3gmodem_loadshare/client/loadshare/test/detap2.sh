#!/bin/bash

echo Tap2 down.
ip addr del 10.45.48.2/24 dev tap2
ifenslave -d bond0 tap2

