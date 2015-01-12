# jenkins

This docker is to build jenkins for git CI with docker integration.
It is available on Docker Hub https://registry.hub.docker.com/u/jacekmarchwicki/jenkins/ .

## Build image

```bash
docker build --tag jacekmarchwicki/jenkins .
```

If building fail you can debug (where `1b372b1f76f2` is partial build) via:

```bash
docker run --tty --interactive --rm 1b372b1f76f2 /bin/bash
```

## Push build version to repository

```bash
docker push jacekmarchwicki/jenkins
```

## Usage

### Create shared jenkins

```bash
docker run --volume /jenkins --name jenkins-data busybox true
```

### Setup google cloud storage login (optional)
* Go to [Google cloud console](https://console.developers.google.com/)
* Open your project
* Go to APIs & auth
* Go to Credentails
* Generate Create new Client ID
* Choose Service Account
* Download p12 key
* Run command:

```bash
docker run --volumes-from jenkins-data \
  --volume <your-key>:/tmp/your-key.p12 \
  --tty \
  --interactive \
  --publish 8080:8080 \
  --privileged \
  --rm jacekmarchwicki/jenkins \
  gcloud auth activate-service-account <your-service-account-email> --key-file /tmp/your-key.p12 --project <your-project-id>
```

### Run jenkins and docker

```bash
docker run --volumes-from jenkins-data \
  --tty \
  --interactive \
  --publish 8080:8080 \
  --privileged \
  --rm jacekmarchwicki/jenkins \
  run.sh
```

### Debug
To look on `/jenkins` directory you can run ubuntu docker in interactive mode

```bash
docker run --interactive \
  --tty \
  --volumes-from jenkins-data \
  --publish 8080:8080 \
  --privileged \
  --rm \
  jacekmarchwicki/jenkins \
  /bin/bash
```

### Backup

```bash
docker run \
  --tty \
  --interactive \
  --volumes-from jenkins-data \
  --volume=$(pwd):/backup \
  ubuntu:12.04 \
  tar cvf /backup/backup_$(date +"%Y-%d-%m_%H%M%S").tar /jenkins
```

### Restore

```bash
docker run --volume /jenkins \
  --tty \
  --interactive \
  --name jenkins-data2 \
  busybox \
  true
docker run --volumes-from jenkins-data2 \
  --tty \
  --interactive \
  --volume=$(pwd):/backup \
  busybox \
  tar xvf /backup/backup.tar
docker run --volumes-from jenkins-data2 \
  --tty \
  --interactive \
  --publish 8081:8080 \
  --privileged \
  --rm \
  jacekmarchwicki/jenkins \
  run.sh
```

Now your restored jenkins should be visible on port `8081`.

You can remove your restored volume by

```bash
docker rm jenkins-data2
```

## Running build inside jenkins docker
Add to your build script

```bash
# Test connection to docker
docker version || exit 1

# Copy your keystore
gsutil cp gs://<your-private-bucket>/keystores/your-key.keystore Yapert/your-key.keystore || exit 1

cat > script.sh << EOF
#!/bin/bash
./gradlew build
EOF
chmod u+x script.sh  || exit 1

docker run --interactive --volume=$(pwd):/opt/workspace --workdir=/opt/workspace --rm jacekmarchwicki/android-test "/opt/workspace/script.sh" || exit 1
```
