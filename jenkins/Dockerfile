FROM dockerfile/java:oracle-java7
MAINTAINER Jacek Marchwicki "jacek.marchwicki@gmail.com"

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9 && echo deb http://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list

RUN apt-get update && apt-get install -y git wget curl telnet openssh-client python unzip lxc-docker python-openssl && apt-get clean

RUN mkdir -p /opt && cd /opt/ && wget https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.zip && unzip google-cloud-sdk.zip && rm google-cloud-sdk.zip && google-cloud-sdk/install.sh --usage-reporting=true --path-update=true --bash-completion=true --rc-path=/.bashrc --disable-installation-options
ENV PATH /opt/google-cloud-sdk/bin:$PATH
RUN yes | gcloud components update

ENV CLOUDSDK_CONFIG /jenkins/gcloud
ENV CLOUDSDK_PYTHON_SITEPACKAGES 1

ADD http://mirrors.jenkins-ci.org/war/1.596/jenkins.war /opt/jenkins.war
RUN chmod 644 /opt/jenkins.war
ENV JENKINS_HOME /jenkins

COPY run.sh /usr/bin/

RUN mkdir -p /opt/workspace
WORKDIR /opt/workspace

EXPOSE 8080
