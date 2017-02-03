Rails.application.routes.draw do

  mount MicroservicesEngine::Engine => "/microservices-engine"
end
