# Go CD

## Building

```bash
docker build --tag appunite/go-cd:14.4.0 .
```

## Running

```bash
docker run -v /go/ldap:/var/lib/ldap \
			-e LDAP_ORGANISATION="AppUnite Sp. z o.o." \
			-e LDAP_DOMAIN="appunite.com" \
			-e LDAP_DC="dc=appunite,dc=com" \
			-v /go/etc:/etc/go \
			-v /go/data:/data/artifacts \
			-v /go/var:/var/go \
			-v /go/lib:/var/lib/ldap \
			-p 8153:8153  \
			appunite/go-cd:14.4.0
```			
	
## TTY

```bash
docker run -v /go/ldap:/var/lib/ldap \
			-e LDAP_ORGANISATION="AppUnite Sp. z o.o." \
			-e LDAP_DOMAIN="appunite.com" \
			-e LDAP_DC="dc=appunite,dc=com" \
			-v /go/etc:/etc/go \
			-v /go/data:/data/artifacts \
			-v /go/var:/var/go \
			-v /go/lib:/var/lib/ldap \
			--tty -i \
			appunite/go-cd:14.4.0  /bin/bash
```
			