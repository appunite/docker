# android-java8
DEPRECATED use [java7-8](../java7-8/README.md)

This docker is to build Android Gradle project with Java 8.
It is available on Docker Hub https://registry.hub.docker.com/u/jacekmarchwicki/android/ .

Contains:

* Android SDK: r24.3.3
* Build tools: 21, 21.0.1, 21.0.2, 21.1, 21.1.1, 21.1.2, 22, 22.0.1, 23.0.0, 23.0.3
* Android API: 21, 22, 23, 24
* Support maven repository
* Google maven repository
* Arm emulator: v21
* Platform tools
* Created emulator image named: "Nexus 5"

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

