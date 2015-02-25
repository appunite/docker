FROM phusion/passenger-ruby21:0.9.15
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

MAINTAINER Karol Wojtaszek, karol@appunite.com

CMD ["/sbin/my_init"]

RUN rm /etc/nginx/sites-enabled/default
ADD image/gitlab-ci.conf /etc/nginx/sites-enabled/gitlab-ci.conf

RUN apt-get update -qq && apt-get install -y wget curl gcc checkinstall libxml2-dev libxslt-dev libcurl4-openssl-dev libreadline6-dev libc6-dev libssl-dev libmysql++-dev make build-essential zlib1g-dev openssh-server git-core libyaml-dev libpq-dev libicu-dev openssl libpq-dev && apt-get clean
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV APP_HOME /home/gitlab_ci/

RUN adduser --disabled-login --gecos 'GitLab CI' gitlab_ci
USER gitlab_ci


WORKDIR $APP_HOME
RUN git clone https://gitlab.com/gitlab-org/gitlab-ci.git app
WORKDIR $APP_HOME/app

RUN git checkout 7-8-stable
RUN cp config/application.yml.example config/application.yml

RUN mkdir -p tmp/sockets/
RUN chmod -R u+rwX  tmp/sockets/
RUN mkdir -p tmp/pids/
RUN chmod -R u+rwX  tmp/pids/

RUN bundle install --without development test mysql --deployment
RUN cp config/database.yml.postgresql config/database.yml

EXPOSE 80
