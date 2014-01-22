#!/bin/bash

echo tap2 up.
ip addr add 10.45.48.2/24 dev tap2
ifenslave bond0 tap2

