# frozen_string_literal: true
require 'net/http'
require 'net/https'
require 'microservices_engine/engine' if defined? Rails

module MicroservicesEngine
  mattr_accessor :build

  class << self
    def build=(b)
      b = b.to_i

      raise 'Received build is older than existing' unless build > b
      write_attribute(:build, b)
    end

    def valid_token?(token)
      # TODO
      #
      # Implement the logic to verify tokens
      token == 'abc'
    end

    def data(objectName, *attributes)
      MicroservicesEngine::Connection.data(objectName, *attributes)
    end

    def test_def(n)
      n ||= 1
      'a' * n
    end
  end
end
