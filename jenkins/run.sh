#!/bin/bash

export JAVA_OPTS="-XX:MaxPermSize=1024m -Xms1024m -Xmx2048m"
java -jar /opt/jenkins.war $@
