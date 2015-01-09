#!/bin/bash

service docker start
java -jar /opt/jenkins.war $@
