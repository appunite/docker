FROM dockerfile/java:oracle-java7
MAINTAINER Karol Wojtaszek <karol@appunite.com>

RUN apt-get -y update && apt-get install --no-install-recommends -y -qq curl docker.io git openssh-client unzip ruby ca-certificates patch gawk g++ gcc make libc6-dev patch libreadline6-dev zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 autoconf libgdbm-dev libncurses5-dev automake libtool bison pkg-config libffi-dev && apt-get clean all

# install go agent
RUN wget -O /tmp/go-agent.deb http://download.go.cd/gocd-deb/go-agent-14.4.0-1356.deb && dpkg -i /tmp/go-agent.deb && rm /tmp/go-agent.deb
RUN echo "DAEMON=n" > /etc/default/go-agent
ADD image /

# install rvm
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3; \curl -sSL https://get.rvm.io | bash -s stable
ONBUILD RUN /bin/bash -l -c "source /etc/profile.d/rvm.sh"
RUN /bin/bash -l -c "rvm install 2.1"
RUN /bin/bash -l -c "echo 'gem: --no-ri --no-rdoc' > ~/.gemrc"
RUN /bin/bash -l -c "gem install bundler --no-ri --no-rdoc"

# install redis
RUN sh /opt/go/install_redis.sh

# install mongodb
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
RUN echo 'deb http://downloads-distro.mongodb.org/repo/debian-sysvinit dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list
RUN apt-get -y update && apt-get install -y mongodb-org && service mongod start && apt-get clean all

# install postgresql
RUN apt-get install -y postgresql postgresql-client

CMD rm /usr/share/go-agent/.agent-bootstrapper.running; sh /opt/go/start.sh
