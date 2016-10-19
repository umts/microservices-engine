# frozen_string_literal: true
require 'net/http'
require 'net/https'
require 'microservices_engine/engine' if defined? Rails

module MicroservicesEngine
  # For potential security issues, this will remain as an attr_accessor
  # which disallows modification of this from outside the module, so it
  # will have to go through `build=` to be modified or `build` to be read


  class << self
    def build=(b)
      if Rails.env.test? && b == '1.1.1'
        @build = b
      end

      # -- Semantic Versioning -- #
      # - All version INCREASES are VALID
      # - Version DECREASES are INVALID IF AND ONLY IF none of the more important
      #   version numbers increase.
      #   ~ That is to say, a major decrease is never valid.
      #   ~ A minor decrease is only valid when the major version increases.
      #   ~ A revision decrease is only valid when either the major or minor version increases.

      major, minor, rev = b.split('.').map(&:to_i)
      cmajor, cminor, crev = build.split('.').map(&:to_i)
      invalid_changes =
        [                                     # -- Examples -- #
          cmajor > major,                     # 2.3.2 -> 1.3.2 #
          cminor > minor && cmajor <= major,  # 1.2.3 -> 1.1.3 #
                                              # 1.2.3 -> 0.2.3 #
          crev > rev && cminor <= minor &&    # 1.2.3 -> 1.2.2 #
            crev <= rev                       # 1.2.3 -> 1.1.2 #
                                              # 1.2.3 -> 0.2.3 #
                                              # 1.2.3 -> 0.1.2 #
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

    def get(options, reqs, attrs = [])
      MicroservicesEngine::Connection.data(options, reqs, attrs)
    end

    def test_def(n)
      n ||= 1
      'a' * n
    end
  end
end
