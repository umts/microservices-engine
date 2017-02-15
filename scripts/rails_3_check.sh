#!/bin/sh

if [ "$RAILS_VERSION" = "3" ]; then
  bundle install --without ruby_2
fi
