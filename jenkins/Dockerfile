FROM dockerfile/java:oracle-java7
MAINTAINER Jacek Marchwicki "jacek.marchwicki@gmail.com"

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9 && echo deb http://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list

RUN apt-get update && apt-get install -y git wget curl telnet lxc-docker && apt-get clean

ADD http://mirrors.jenkins-ci.org/war/1.596/jenkins.war /opt/jenkins.war
RUN chmod 644 /opt/jenkins.war
ENV JENKINS_HOME /jenkins

COPY run.sh /usr/bin/

RUN mkdir -p /opt/workspace
WORKDIR /opt/workspace

EXPOSE 8080
