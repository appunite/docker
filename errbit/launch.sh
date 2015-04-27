#!/bin/bash

set -x

if [ -z "$MONGODB_URL" -a -n "$MONGODB_PORT" ]; then
  export MONGODB_URL="$MONGODB_PORT/errbit"
fi
export PATH=/opt/ruby/bin:$PATH
if [ -z "$SECRET_TOKEN" -a ! -f "config/initializers/__secret_token.rb" ]; then
  echo "Errbit::Application.config.secret_token = '$(bundle exec rake secret)'" > config/initializers/__secret_token.rb
fi
if [ "$1" == "web" ]; then
  bundle exec unicorn -p 3000 -c /opt/errbit/app/config/unicorn.rb
elif [ "$1" == "seed" ]; then
  bundle exec rake db:seed
  bundle exec rake db:mongoid:create_indexes
else
  bundle exec unicorn -p 3000 -c /opt/errbit/app/config/unicorn.rb
fi