module MicroservicesEngine
  class Configuration < ActiveRecord::Base
    attr_reader :endpoint_models

    def initialize
      @endpoint_models = []
    end
  end
end
