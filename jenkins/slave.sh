#!/bin/bash

echo "root:${ROOT_PASSWORD:-notasecret}" | chpasswd

if [ ! -d /var/run/sshd ]; then
   mkdir /var/run/sshd
   chmod 0755 /var/run/sshd
fi

/usr/sbin/sshd -D
