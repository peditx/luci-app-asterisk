#!/bin/sh

read -p "Enter SIP User to delete: " dele

if [[ $dele =~ ^[0-9]+$ ]]; then
    sed -i "/\;$dele\>/d" /etc/asterisk/pjsip.conf

    service asterisk restart
else
    echo "ERROR: Invalid SIP User"
fi
