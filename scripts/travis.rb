#!/usr/bin/env ruby
if ENV['RAILS_VERSION'] == '5'
  system( "RAILS_ENV=test bundle exec rails db:create db:migrate" )
else
  system( "RAILS_ENV=test bundle exec rake db:create" )
  system( "RAILS_ENV=test bundle exec rake db:migrate" )
end
