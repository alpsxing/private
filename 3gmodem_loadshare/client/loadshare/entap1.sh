#!/bin/bash

ip addr add 10.45.47.2/24 dev tap1
ifenslave bond0 tap1

