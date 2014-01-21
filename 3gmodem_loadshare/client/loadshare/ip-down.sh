#!/bin/bash

PPP_IFACE="$1"
PPP_LOCAL="$2"
PPP_REMOTE="$3"

logger LOADSHARE PPP DOWN $PPP_IFACE $PPP_LOCAL $PPP_REMOTE

if [ -f "/var/loadshare_test" ]; then
    logger LOADSHARE PPP Down Test mode
    exit 0
fi

SERIAL_NUMBER=`cat /var/unicom_serial`
if [ -n $SERIAL_NUMBER ]; then
    if [ "/dev/ttyUSB${SERIAL_NUMBER}" = $PPP_IFACE ]; then
        logger LOADSHARE PPP Down Find Unicom PPP Link
        /etc/loadshare/stop_tap0_from_ppp.sh $PPP_LOCAL $PPP_REMOTE
        exit 0
    fi
fi

SERIAL_NUMBER=`cat /var/telecom_serial`
if [ -n $SERIAL_NUMBER ]; then
    if [ "/dev/ttyUSB${SERIAL_NUMBER}" = $PPP_IFACE ]; then
        logger LOADSHARE PPP Down Find Telecom PPP Link
        /etc/loadshare/stop_tap1_from_ppp.sh $PPP_LOCAL $PPP_REMOTE
        exit 0
    fi
fi


