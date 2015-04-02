#!/bin/bash

java -jar /opt/jenkins.war -XX:MaxPermSize=4096m -Xms4096m -Xmx8192m $@
