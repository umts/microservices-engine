# frozen_string_literal: true
module MicroservicesEngine
  class Engine < ::Rails::Engine
    isolate_namespace MicroservicesEngine

    config.generators do |g|
      g.test_framework :rspec
    end
  end

  Engine.routes.draw do
    namespace :v1 do
      resources :data
    end
  end
end
