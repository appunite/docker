#!/bin/bash

sh /opt/go/openldap_init.sh

chown -R go:go /etc/go
chown -R go:go /data/artifacts
chown -R go:go /var/go

sh /opt/go/go_init.sh

eval `ssh-agent -s`

ssh-add ~/.ssh/id_rsa
ssh-add ~/.ssh/id_dsa

/etc/init.d/go-server start && tail -f /var/log/go-server/go-server.log