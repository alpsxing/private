#!/bin/bash

ip addr del 10.45.47.2/24 dev tap1
ifenslave -d bond0 tap1

