# Go CD

## Building

```bash
docker build --tag appunite/go-cd:14.4.0 .
```

## Setup

```bash
docker run \
			-v /etc/go \
			-v /data/artifacts \
			-v /var/go \
			-v /var/lib/ldap \
			--name go-cd-data busybox true
```

## Running

```bash
docker run \
			-e LDAP_ORGANISATION="AppUnite Sp. z o.o." \
			-e LDAP_DOMAIN="appunite.com" \
			-e LDAP_DC="dc=appunite,dc=com" \
			--volumes-from go-cd-data \
			-p 127.0.0.1:8153:8153  \
			-p 127.0.0.1:8154:8154 -d  \
			--name go-cd \
			appunite/go-cd:14.4.0
```			

### Logging in

By default we enabled authentication, default user:
Login: admin
Password: password

	
## TTY

```bash
docker run -e LDAP_ORGANISATION="AppUnite Sp. z o.o." -e LDAP_DOMAIN="appunite.com" -e LDAP_DC="dc=appunite,dc=com" --volumes-from go-cd-data  --tty -i  appunite/go-cd:14.4.0  /bin/bash
```

## Nginx proxy

```
server {
        listen 80;

        server_name ci.appunite.net ci.appunite.com;
        location / {
                return 301 https://ci.appunite.net/;
        }
}

server {
        listen 443;
        server_name ci.appunite.net ci.appunite.com;

        ssl on;
        ssl_certificate /etc/nginx/keys/appunite.net.crt;
        ssl_certificate_key /etc/nginx/keys/appunite.net.key;

        access_log /var/log/nginx/ci/access.log main;
        error_log /var/log/nginx/ci/error.log warn;

        location / {
                proxy_pass      https://127.0.0.1:8154;
		proxy_set_header        Host $host;
		proxy_set_header        X-Real-IP $remote_addr;
		proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
		proxy_set_header        X-Forwarded-Proto $scheme;
        }
}
```

## Backup

```bash
docker run \
  --tty \
  --interactive \
  --volumes-from go-cd-data \
  --volume=$(pwd):/backup \
  ubuntu:14.04 \
  tar zcvf /backup/go-cd_backup_$(date +"%Y-%d-%m_%H%M%S").tar.gz /etc/go /data/artifacts /var/go /var/lib/ldap
```
			
## Restore

```bash
docker run --volumes-from go-cd-data2 \
  --tty \
  --interactive \
  --volume=$(pwd):/backup \
  ubuntu:14.04 \
  tar -zxvf /backup/go-cd_backup_2015-13-01_120433.tar
```