cd /tmp
wget http://download.redis.io/releases/redis-2.8.19.tar.gz
tar -xzf redis-2.8.19.tar.gz
cd redis-2.6.19
make install

rm -rf /tmp/redis*

adduser --system --no-create-home --disabled-login --disabled-password --group redis

touch /var/log/redis.log
chown redis:redis /var/log/redis.log
chmod u+w /var/log/redis.log

cd /etc/init.d/
wget https://gist.github.com/peterc/408762/raw -O redis
chmod u+x redis
update-rc.d -f redis defaults

mkdir /var/redis
chown redis:redis /var/redis
chmod u+xw /var/redis

mkdir /etc/redis
touch /etc/redis/redis.conf
chown redis:redis -R /etc/redis/
 
 
  cat<<EOF > /etc/redis/redis.conf
daemonize yes
pidfile /var/run/redis.pid
logfile /var/log/redis.log
port 6379
# bind 127.0.0.1
# unixsocket /tmp/redis.sock
timeout 300
loglevel verbose
databases 16
save 900 1
save 300 10
save 60 10000
rdbcompression yes
dbfilename dump.rdb
dir /var/redis/
# requirepass foobared
EOF

/etc/init.d/redis start