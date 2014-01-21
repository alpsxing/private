#!/bin/bash

PPP_IFACE="$1"
PPP_LOCAL="$2"
PPP_REMOTE="$3"

logger LOADSHARE PPP UP $PPP_IFACE $PPP_LOCAL $PPP_REMOTE

if [ -f "/var/loadshare_test" ]; then
    logger LOADSHARE PPP UP Test mode
    exit 0
fi

SERIAL_NUMBER=`cat /proc/tty/driver/usbserial | grep "vendor:12d1 product:1506" | sed -n 's/://'p | awk '{print $1}' | sed -n '1p'`

if [ -n $SERIAL_NUMBER ]; then
    if [ "/dev/ttyUSB${SERIAL_NUMBER}" = $PPP_IFACE ]; then
        echo $SERIAL_NUMBER > /var/unicom_serial
        logger LOADSHARE PPP UP Find Unicom PPP Link
        /etc/loadshare/start_tap0_from_ppp.sh $PPP_LOCAL $PPP_REMOTE
        exit 0
    fi
fi

SERIAL_NUMBER=`cat /proc/tty/driver/usbserial | grep "vendor:12d1 product:140c" | sed -n 's/://'p | awk '{print $1}' | sed -n '1p'`

if [ -n $SERIAL_NUMBER ]; then
    if [ "/dev/ttyUSB${SERIAL_NUMBER}" = $PPP_IFACE ]; then
        echo $SERIAL_NUMBER > /var/telecom_serial
        logger LOADSHARE PPP UP Find Telecom PPP Link
        /etc/loadshare/start_tap1_from_ppp.sh $PPP_LOCAL $PPP_REMOTE
        exit 0
    fi
fi


