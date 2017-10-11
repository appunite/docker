# android java7 and java8 (with NDK)

This docker is to build Android Gradle project with Java 7 and Java 8.
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
# setup android sdk and licenses
export GRADLE_USER_HOME="$(pwd)/.gradle"
export ANDROID_HOME="$(pwd)/.android"
mkdir -p "${ANDROID_HOME}/licenses"
echo -e "\n8933bad161af4178b1185d1a37fbf41ea5269c55\nd56f5187479451eabf01fb78af6dfcb131a6481e" > "${ANDROID_HOME}/licenses/android-sdk-license"
echo -e "\n84831b9409646a918e30573bab4c9c91346d8abd" > "${ANDROID_HOME}/licenses/android-sdk-preview-license"
echo -e "\nd975f751698a77b662f1254ddbeed3901e976f5a" > "${ANDROID_HOME}/licenses/intel-android-extra-license"
./gradlew --parallel --stacktrace --no-daemon build 
```

If you want build with NDK:

```bash
# setup android sdk and licenses
export GRADLE_USER_HOME="$(pwd)/.gradle"
export ANDROID_HOME="$(pwd)/.android"
export ANDROID_NDK_HOME="${ANDROID_HOME}/ndk-bundle"
mkdir -p "${ANDROID_HOME}"
if [ ! -f ${ANDROID_HOME}/ndk.zip ]; then wget -O ${ANDROID_HOME}/ndk.zip --quiet https://dl.google.com/android/repository/android-ndk-r13b-linux-x86_64.zip; fi
if [ ! -d ${ANDROID_NDK_HOME} ]; then unzip ${ANDROID_HOME}/ndk.zip -d /tmp/ > /dev/null; mv /tmp/* ${ANDROID_NDK_HOME}; ls ${ANDROID_NDK_HOME}/; fi
mkdir -p "${ANDROID_HOME}/licenses"
echo -e "\n8933bad161af4178b1185d1a37fbf41ea5269c55" > "${ANDROID_HOME}/licenses/android-sdk-license"
echo -e "\n84831b9409646a918e30573bab4c9c91346d8abd" > "${ANDROID_HOME}/licenses/android-sdk-preview-license"
echo -e "\nd975f751698a77b662f1254ddbeed3901e976f5a" > "${ANDROID_HOME}/licenses/intel-android-extra-license"
./gradlew --parallel --stacktrace --no-daemon build 
```

**TIP**: If you are using CI I suggest to cache `.gradle` and `.android` so dependencies will not be downloaded all the time

## Build image

```bash
docker build -t jacekmarchwicki/android:ubuntu-16-04-java7-8 .
```

If building fail you can debug via where `1b372b1f76f2` is partial build

```bash
docker run --tty --interactive --rm 1b372b1f76f2 /bin/bash
```

