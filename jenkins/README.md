# android-java7

This docker is to build jenkins for git CI with docker integration.
It is available on Docker Hub https://registry.hub.docker.com/u/jacekmarchwicki/jenkins/ .

## Build image

```bash
docker build --tag jacekmarchwicki/jenkins .
```

If building fail you can debug via where `1b372b1f76f2` is partial build

```bash
docker run --tty --interactive --rm 1b372b1f76f2 /bin/bash
```

## Push build version to repository

```bash
docker push jacekmarchwicki/jenkins
```

## Usage

Create shared jenkins

```bash
docker run --volume /jenkins --name jenkins-data busybox true
```

Run jenkins

```bash
docker run --volumes-from jenkins-data --publish 8080:8080 --rm jacekmarchwicki/jenkins
```

### Debug
To look on `/jenkins` directory you can run ubuntu docker in interactive mode

```bash
docker run --tty --interactive --rm --volumes-from jenkins-data ubuntu:12.04 /bin/bash
```

### Backup

```bash
docker run --volumes-from jenkins-data \
  --volume=$(pwd):/backup \
  ubuntu:12.04 \
  tar cvf /backup/backup_$(date +"%Y-%d-%m_%H%M%S").tar /jenkins
```

### Restore

```bash
docker run --volume /jenkins \
  --name jenkins-data2 \
  busybox \
  true
docker run --volumes-from jenkins-data2 \
  --volume=$(pwd):/backup \
  busybox \
  tar xvf /backup/backup.tar
docker run --volumes-from jenkins-data2 \
  --publish 8081:8080 \
  --rm \
  jacekmarchwicki/jenkins
```

Now your restored jenkins should be visible on port `8081`.

You can remove your restored volume by

```bash
docker rm jenkins-data2
```
