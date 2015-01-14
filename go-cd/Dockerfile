FROM dockerfile/java:oracle-java7
MAINTAINER Karol Wojtaszek, karol@appunite.com

RUN wget -O /tmp/go-server.deb http://download.go.cd/gocd-deb/go-server-14.4.0-1356.deb && dpkg -i /tmp/go-server.deb && rm /tmp/go-server.deb

VOLUME /etc/go
VOLUME /data/artifacts
VOLUME /var/go

ADD image /

EXPOSE 8153
EXPOSE 8154

# OpenLDAP configuration
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -y update && apt-get -y install slapd ldap-utils && apt-get clean
EXPOSE 389
VOLUME /var/lib/ldap

CMD sh /opt/go/start.sh
