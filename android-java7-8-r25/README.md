# android java7 and java8

This docker is to build Android Gradle project with Java 8 and Java 8.
It is available on Docker Hub https://registry.hub.docker.com/u/jacekmarchwicki/android/ .

## Setting default java:
* java8 (default) `update-java-alternatives --set java-8-oracle`, directory: `/usr/lib/jvm/java-8-oracle`
* java7 `update-java-alternatives --set java-7-oracle`, directory: `/usr/lib/jvm/java-7-oracle`


## Build image

```bash
docker build -t jacekmarchwicki/android .
```

If building fail you can debug via where `1b372b1f76f2` is partial build

```bash
docker run --tty --interactive --rm 1b372b1f76f2 /bin/bash
```

## Push build version to repository

```bash
docker push jacekmarchwicki/android:java8
```

## Usage
Change directory to your project directory, than run:

```bash
docker run --tty --interactive --volume=$(pwd):/opt/workspace --workdir=/opt/workspace --rm jacekmarchwicki/android:java8  /bin/sh -c "./gradlew build"
```

