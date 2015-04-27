FROM ruby:2.2.0

MAINTAINER Karol Wojtaszek <karol@appunite.com>

# OS-Level dependencies
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
  git \
  libxml2 \
  libxml2-dev \
  libxslt-dev \
  libcurl4-openssl-dev \
  nodejs

# Setup environment
ENV RAILS_ENV production
ENV USE_ENV true

# Create errbit user
RUN /usr/sbin/useradd --create-home --home-dir /opt/errbit --shell /bin/bash errbit

# Get errbit code
RUN mkdir /opt/errbit/app

# Set-up app
WORKDIR /opt/errbit/app
RUN git clone https://github.com/appunite/errbit.git .
RUN cp /opt/errbit/app/config/unicorn.default.rb /opt/errbit/app/config/unicorn.rb
RUN bundle install --deployment
RUN chown -R errbit:errbit /opt/errbit/app

ADD launch.sh /opt/launch.sh
RUN chmod +x /opt/launch.sh

USER errbit
RUN bundle exec rake assets:precompile

EXPOSE 3000

ENTRYPOINT /opt/launch.sh
CMD ["web"]