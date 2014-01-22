#!/bin/bash

PPP_DEV="$1"
PPP_LOCAL="$2"
PPP_REMOTE="$3"
PPP_IFACE="$4"

logger LOADSHARE PPP DOWN $PPP_DEV $PPP_LOCAL $PPP_REMOTE $PPP_IFACE

if [ -f "/var/loadshare_test" ]; then
    logger LOADSHARE PPP Down Test mode
    exit 0
fi

SERIAL_NUMBER=`cat /var/unicom_serial`
if [ -n $SERIAL_NUMBER ]; then
    if [ "/dev/ttyUSB${SERIAL_NUMBER}" = $PPP_DEV ]; then
        logger LOADSHARE PPP Down Find Unicom PPP Link
        /etc/loadshare/stop_tap0_from_ppp.sh $PPP_LOCAL $PPP_REMOTE
        exit 0
    fi
fi

SERIAL_NUMBER=`cat /var/telecom_serial`
if [ -n $SERIAL_NUMBER ]; then
    if [ "/dev/ttyUSB${SERIAL_NUMBER}" = $PPP_DEV ]; then
        logger LOADSHARE PPP Down Find Telecom PPP Link
        /etc/loadshare/stop_tap1_from_ppp.sh $PPP_LOCAL $PPP_REMOTE
        exit 0
    fi
fi

SERIAL_NUMBER=`cat /var/cmcc_serial`
if [ -n $SERIAL_NUMBER ]; then
    if [ "/dev/ttyUSB${SERIAL_NUMBER}" = $PPP_DEV ]; then
        logger LOADSHARE PPP Down Find Cmcc PPP Link
        /etc/loadshare/stop_tap2_from_ppp.sh $PPP_LOCAL $PPP_REMOTE
        exit 0
    fi
fi

