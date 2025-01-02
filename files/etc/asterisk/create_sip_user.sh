#!/bin/sh

read -p "Enter SIP User: " user
read -p "Enter SIP Password: " pass

if [[ $user =~ ^[0-9]+$ ]]; then
    USR=$(grep -o "aors = ${user}" /etc/asterisk/pjsip.conf | grep -o '[[:digit:]]*' | sed -n '1p')

    if [ "$USR" == "${user}" ]; then
        echo "ERROR: User ${user} already exists"
    else

        echo "[${user}]
type = endpoint
context = internal
disallow = all
allow = alaw
aors = ${user}
auth = auth${user}
direct_media = no

[${user}]
type = aor
max_contacts = 1
support_path = yes

[auth${user}]
type = auth
auth_type = userpass
password = ${pass}
username = ${user}" >> /etc/asterisk/pjsip.conf

        service asterisk restart
    fi
else
    echo "ERROR: Invalid SIP User"
fi
