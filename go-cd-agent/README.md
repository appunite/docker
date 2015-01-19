# Go CD Agent

## Building

```bash
docker build --tag appunite/go-cd-agent:latest .
```

## Running

```bash
docker run -e GO_SERVER=ci.appunite.net -e AGENT_KEY=xxx -e AGENT_RESOURCES=test -e AGENT_ENV=rails -d --name go-cd-agent -i --tty appunite/go-cd-agent:latest /bin/bash 
```

## TTY

```bash
docker run \
      -e GO_SERVER=ci.appunite.net \
			--tty -i \
			appunite/go-cd-agent:14.4.0 /bin/bash
```			

