# frozen_string_literal: true
require 'net/http'
require 'net/https'
require 'microservices_engine/engine' if defined? Rails

module MicroservicesEngine
  # For potential security issues, this will remain as an attr_accessor
  # which disallows modification of this from outside the module, so it
  # will have to go through `build=` to be modified or `build` to be read
  attr_accessor :build

  class << self
    def build=(b)
      b = b.to_i

      raise 'Received build is older than existing' unless build > b
      write_attribute(:build, b)
    end

    def build
      build
    end

    def valid_token?(token)
      # TODO
      #
      # Implement the logic to verify tokens
      token == 'abc'
    end

    def get(options, reqs, attrs = [])
      MicroservicesEngine::Connection.data(options, reqs, attrs = [])
    end

    def test_def(n)
      n ||= 1
      'a' * n
    end
  end
end
