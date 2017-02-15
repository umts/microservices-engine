#!/bin/sh

if [ "$RAILS_VERSION" = "5" ]; then
  bundle install --gemfile=gemfiles/rails_5.gemfile
  bundle exec rails db:create db:migrate
elif [ "$RAILS_VERSION" = "4" ]; then
  bundle install --gemfile=gemfiles/rails_4.gemfile
  bundle exec rake db:create db:migrate
elif [ "$RAILS_VERSION" = "3" ]; then
  bundle install --gemfile=gemfiles/rails_3.gemfile
  bundle exec rake db:create db:migrate
else
  bundle install
  bundle exec rails db:create db:migrate
fi
