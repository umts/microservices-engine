require "net/http"
require "net/https"
require "microservices_engine/engine" if defined? Rails

module MicroservicesEngine

  class << self
    def data(objectName, *attributes)
      MicroservicesEngine::Connection.data(objectName, *attributes)
    end

    def test_def(n)
      n ||= 1
      return "a" * n
    end
  end
end
