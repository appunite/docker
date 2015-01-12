#!/bin/bash

service docker start
sleep 3
service docker status || exit 1
java -jar /opt/jenkins.war $@
