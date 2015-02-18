#!/bin/bash

# Fail hard and fast
set -eo pipefail

export ETCD_PORT=${ETCD_PORT:-4001}
export HOST_IP=${HOST_IP:-172.17.42.1}
export ETCD=$HOST_IP:4001

echo "[nginx] booting container. ETCD: $ETCD"

# Loop until confd has updated the nginx config
until confd -onetime -node $ETCD -config-file /etc/confd/conf.d/nginx-keys.tmpl; do
  echo "[nginx] waiting for confd to refresh nginx.conf"
  sleep 5
done
until confd -onetime -node $ETCD -config-file /etc/confd/conf.d/nginx.toml; do
  echo "[nginx] waiting for confd to refresh nginx.conf"
  sleep 5
done

# Run confd in the background to watch the upstream servers
confd -interval 10 -node $ETCD -config-file /etc/confd/conf.d/nginx-keys.toml &
confd -interval 10 -node $ETCD -config-file /etc/confd/conf.d/nginx.toml &
echo "[nginx] confd is listening for changes on etcd..."

# Start nginx
echo "[nginx] starting nginx service..."
service nginx start

# Tail all nginx log files
tail -f /var/log/nginx/*.log
