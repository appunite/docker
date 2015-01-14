# Go CD

## Building

```bash
docker build --tag appunite/go-cd:14.4.0 .
```

## Setup

```bash
docker run \
			-v /go/etc:/etc/go \
			-v /go/data:/data/artifacts \
			-v /go/var:/var/go \
			-v /go/lib:/var/lib/ldap \
			--name go-cd-data busybox true
```

## Running

```bash
docker run -v /go/ldap:/var/lib/ldap \
			-e LDAP_ORGANISATION="AppUnite Sp. z o.o." \
			-e LDAP_DOMAIN="appunite.com" \
			-e LDAP_DC="dc=appunite,dc=com" \
			--volumes-from go-cd-data \
			-p 8153:8153 -d  \
			-p 8154:8154 -d  \
			appunite/go-cd:14.4.0
```			
	
## TTY

```bash
docker run -v /go/ldap:/var/lib/ldap \
			-e LDAP_ORGANISATION="AppUnite Sp. z o.o." \
			-e LDAP_DOMAIN="appunite.com" \
			-e LDAP_DC="dc=appunite,dc=com" \
			--volumes-from go-cd-data \
			--tty -i \
			appunite/go-cd:14.4.0  /bin/bash
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

			