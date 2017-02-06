# frozen_string_literal: true
source 'https://rubygems.org'
# Declare your gem's dependencies in microservices_engine.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

rails_version = ENV['RAILS_VERSION'] || 'default'

rails = case rails_version

when 'master'
  {github: rails/rails}
when 'default'
  '>=3.2.21'
else
  "~> #{rails_version}"
end

gem 'rails', rails

# To use a debugger
# gem 'byebug', group: [:development, :test]
