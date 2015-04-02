#!/bin/bash

export JAVA_OPTS="-XX:MaxPermSize=4096m -Xms4096m -Xmx8192m"
java -jar /opt/jenkins.war $@
