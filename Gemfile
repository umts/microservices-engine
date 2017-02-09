# frozen_string_literal: true
source 'https://rubygems.org'
# Declare your gem's dependencies in microservices_engine.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# import Gemfiles from each dummy app


rails_version = ENV['RAILS_VERSION']

if ENV.has_key?'RAILS_VERSION'
  rails_version = ENV['RAILS_VERSION']
  if rails_version == '3'
    eval_gemfile File.join(File.dirname(__FILE__), "gemfiles/rails3.gemfile")
  elsif rails_version == '4'
    eval_gemfile File.join(File.dirname(__FILE__), "gemfiles/rails4.gemfile")
  else
    eval_gemfile gemspec
  end
end

  #when 'master'
  #  {github: rails/rails}
  #when 'default'
  #  '>=3.2.21'
  #else
  #  "~> #{rails_version}"
  #end

#gem 'rails', rails

# when rails 4.2.6 => use ruby 2.3.1
# when rails 3.2.21 => use ruby 1.9.3
# when rails default (5.0.1) use ruby 2.3.1

# To use a debugger
# gem 'byebug', group: [:development, :test]
