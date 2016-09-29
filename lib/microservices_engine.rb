# frozen_string_literal: true
require 'net/http'
require 'net/https'
require 'microservices_engine/engine' if defined? Rails

module MicroservicesEngine
  mattr_accessor :build

  class << self
    def set_build(build_num) # Operator overloading for attr_accessors where?
      build_num = build_num.to_i

      raise 'Received build is older than existing' unless build > build_num
      build = build_num
    end

    def valid_token?(token)
      # TODO
      #
      # Implement the logic to verify tokens
      return token == 'abc'
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
