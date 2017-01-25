# android java7 and java8

This docker is to build Android Gradle project with Java 8 and Java 8.
It is available on Docker Hub https://registry.hub.docker.com/u/jacekmarchwicki/android/ .

Other images with android tools are deprecated

Ubuntu: 16.04

## Setting default java:
* java8 (default) `update-java-alternatives --set java-8-oracle`, directory: `/usr/lib/jvm/java-8-oracle`, env: `$JAVA8_HOME` and `$JAVA_HOME`
* java7 `update-java-alternatives --set java-7-oracle`, directory: `/usr/lib/jvm/java-7-oracle`, env: `$JAVA7_HOME`

## Build your app inside docker

Enter to docker in your project directory:

```bash
docker run --tty --interactive --volume=$(pwd):/opt/workspace --workdir=/opt/workspace --rm jacekmarchwicki/android:ubuntu-16-04-java7-8 /bin/sh
```

Then inside docker

```bash
# install and setup android sdk
export ANDROID_HOME=/opt/android-sdk-linux
# accept licenses
mkdir -p "/opt/android-sdk-linux/licenses"
echo -e "\n8933bad161af4178b1185d1a37fbf41ea5269c55" > "/opt/android-sdk-linux/licenses/android-sdk-license"
echo -e "\n84831b9409646a918e30573bab4c9c91346d8abd" > "/opt/android-sdk-linux/licenses/android-sdk-preview-license"
echo -e "\nd975f751698a77b662f1254ddbeed3901e976f5a" > "/opt/android-sdk-linux/licenses/intel-android-extra-license"
./gradlew --parallel --stacktrace --no-daemon build 
```


## Build image

```bash
docker build -t jacekmarchwicki/android:ubuntu-16-04-java7-8 .
```

If building fail you can debug via where `1b372b1f76f2` is partial build

```bash
docker run --tty --interactive --rm 1b372b1f76f2 /bin/bash
```

