module MicroservicesEngine
  class Configuration
    attr_reader :endpoint_models

    def initialize
      @endpoint_models = []
    end
  end
end
