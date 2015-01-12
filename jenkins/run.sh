#!/bin/bash

docker -d &
java -jar /opt/jenkins.war $@
