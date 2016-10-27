# frozen_string_literal: true
require 'net/http'
require 'net/https'
require 'microservices_engine/engine' if defined? Rails

module MicroservicesEngine
  class << self
    def build=(b)
      @build = b if Rails.env.test? && b == '1.1.1'

      # -- Semantic Versioning -- #
      # - All version INCREASES are VALID
      # - Version DECREASES are INVALID IF AND ONLY IF none of the more important
      #   version numbers increase.
      #   ~ That is to say, a major decrease is never valid.
      #   ~ A minor decrease is only valid when the major version increases.
      #   ~ A revision decrease is only valid when either the major or minor version increases.

      major, minor, rev = b.split('.').map(&:to_i)
      cmajor, cminor, crev = build.split('.').map(&:to_i)

      # -- Examples -- #
      # 2.3.2 -> 1.3.2 #
      # 1.2.3 -> 1.1.3 #
      # 1.2.3 -> 0.2.3 #
      # 1.2.3 -> 1.2.2 #
      # 1.2.3 -> 1.1.2 #
      # 1.2.3 -> 0.2.3 #
      # 1.2.3 -> 0.1.2 #
      invalid_changes = [
        cmajor > major,
        cminor > minor && cmajor <= major,
        crev > rev && cminor <= minor && cmajor <= major
      ]

      if invalid_changes.any?
        raise 'Received version is older than existing. Now: #{build}. Given: #{b}'
      end

      @build = b
    end

    def build
      @build ||= '1.1.1'
    end

    def valid_token?(token)
      # TODO
      #
      # Implement the logic to verify tokens
      return token == 'TEST_ENV_VALID_TOKEN' if Rails.env.test?

      token == 'abc'
    end

    def get(resource, path, params = {})
      MicroservicesEngine::Connection.get(resource, path, params)
    end

    def test_def(n)
      n ||= 1
      'a' * n
    end
  end
end
