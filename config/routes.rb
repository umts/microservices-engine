# frozen_string_literal: true
MicroservicesEngine::Engine.routes.draw do
  namespace :v1 do
    resources :data, only: [:update]
  end
end
