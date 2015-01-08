FROM dockerfile/java:oracle-java7
MAINTAINER Jacek Marchwicki "jacek.marchwicki@gmail.com"

RUN apt-get update && apt-get install --force-yes git && apt-get clean

ADD http://mirrors.jenkins-ci.org/war/1.596/jenkins.war /opt/jenkins.war
RUN chmod 644 /opt/jenkins.war
ENV JENKINS_HOME /jenkins

ENTRYPOINT ["java", "-jar", "/opt/jenkins.war"]
EXPOSE 8080
CMD [""]
