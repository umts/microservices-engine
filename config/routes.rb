MicroservicesEngine::Engine.routes.draw do
  namespace :v1 do
    resources :data
  end
end
