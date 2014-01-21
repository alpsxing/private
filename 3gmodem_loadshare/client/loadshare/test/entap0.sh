#!/bin/bash

echo tap0 up.
ip addr add 10.45.46.2/24 dev tap0
ifenslave bond0 tap0

