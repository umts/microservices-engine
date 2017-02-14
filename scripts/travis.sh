#!/bin/sh

if [ "$RAILS_VERSION" = "5" ]; then
  bundle exec rails db:create db:migrate
else
  bundle exec rake db:create
  bundle exec rake db:migrate
fi
