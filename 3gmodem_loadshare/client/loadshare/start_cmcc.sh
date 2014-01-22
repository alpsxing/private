#!/bin/bash

while true; do
    SERIAL_NUMBER=`cat /proc/tty/driver/usbserial | grep "vendor:19d2 product:0003" | sed -n 's/://'p | awk '{print $1}' | sed -n '1p'`
    if [ -z $SERIAL_NUMBER ]; then
        echo "Cmcc dongle not detected."
        sleep 2
        continue
    fi

    sleep 20

    sed "s/\(^Modem\ *=\).*/\1\ \/dev\/ttyUSB${SERIAL_NUMBER}/" < /etc/loadshare/wvdial_cmcc.conf > /var/wvdial_cmcc.conf
    wvdial -C /var/wvdial_cmcc.conf
    rm -f /var/wvdial_cmcc.conf
#    LC_ALL=C  nmcli dev | grep "^ttyUSB${SERIAL_NUMBER}.*disconnected"
#    if [ $? -eq 0 ]; then
#        echo "Unicom dongle disconnected"
#        sleep 10
#        nmcli -t con up id "China Unicom connection"
#        echo "nmcli con up"
#        sleep 15
#    fi
    sleep 2
done

