# frozen_string_literal: true
require 'simplecov'
SimpleCov.start 'rails' do
  # There is no well supported way to test generators in RSpec, so we need to ignore them
  add_filter '/lib/generators/'

  # This file just holds a constant, so we don't really need to test it.
  add_filter '/lib/microservices_engine/version.rb'
end
require 'pry-byebug'
require 'yaml'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
