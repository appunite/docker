FROM dockerfile/java:oracle-java7
MAINTAINER Karol Wojtaszek <karol@appunite.com>

RUN apt-get -y update && apt-get install --no-install-recommends -y -qq curl docker.io git openssh-client unzip ruby ca-certificates && apt-get clean all

RUN wget -O /tmp/go-agent.deb http://download.go.cd/gocd-deb/go-agent-14.4.0-1356.deb && dpkg -i /tmp/go-agent.deb && rm /tmp/go-agent.deb

RUN echo "DAEMON=n" > /etc/default/go-agent

ADD image /

CMD rm /usr/share/go-agent/.agent-bootstrapper.running; sh /opt/go/start.sh
