FROM phusion/passenger-ruby22
MAINTAINER Karol Wojtaszek <karol@appunite.com>

RUN apt-get -y update && apt-get install --no-install-recommends -y -qq curl docker.io git openssh-client wget unzip ruby ca-certificates patch gawk g++ gcc make libc6-dev patch libreadline6-dev zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 autoconf libgdbm-dev libncurses5-dev automake libtool bison pkg-config libffi-dev && apt-get clean all
ADD image /

# install redis
RUN sh /opt/gitlab-ci/install_redis.sh

# install mongodb
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
RUN echo 'deb http://downloads-distro.mongodb.org/repo/debian-sysvinit dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list
RUN apt-get -y update && apt-get install -y mongodb-org && service mongod start && apt-get clean all

# install postgresql
RUN apt-get install -y postgresql postgresql-client

RUN mkdir -p /opt/workspace
WORKDIR /opt/workspace

