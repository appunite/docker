# Go CD Agent

## Building

```bash
docker build --tag appunite/go-cd-agent:14.4.0 .
```

## Running

```bash
docker run \
      -e GO_SERVER=ci.appunite.net \
			-e GO_SERVER_PORT=80 \
			appunite/go-cd-agent:14.4.0 
```

## TTY

```bash
docker run \
      -e GO_SERVER=ci.appunite.net \
			--tty -i \
			appunite/go-cd-agent:14.4.0 /bin/bash
```			

