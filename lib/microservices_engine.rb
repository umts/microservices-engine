require "net/http"
require "net/https"
require "microservices_engine/engine" if defined? Rails
require "microservices_engine/configuration" if defined? Rails

module MicroservicesEngine
  mattr_accessor :config

  class << self
    def configure(&block)
      self.config ||= Configuration.new
      block.call self.config
    end

    def data(objectName, *attributes)
      MicroservicesEngine::Connection.data(objectName, *attributes)
    end

    def test_def(n)
      n ||= 1
      return "a" * n
    end

    def faye_app(options)
      # TO-DO
      # develop a Faye extension for this engine

      opts = {mount: "/mse", timeout: 60, extensions: []}.merge(options)
      Faye::RackAdapter.new(opts)
    end
  end
end
