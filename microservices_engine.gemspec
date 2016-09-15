$:.push File.expand_path("../lib", __FILE__)

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "microservices_engine"
  s.version     = "0.0.1"
  s.authors     = ["Dylan Bowers"]
  s.email       = ["djbowers@umass.edu"]
  s.homepage    = "https://github.com/umts/microservices-engine"
  s.summary     = "Simple UMTS inter-service communication network"
  s.description = s.summary
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "LICENSE", "Rakefile", "README.rdoc"]
  s.require_path = "lib"

  s.test_files = Dir["test/**/*"]

  s.add_dependency "faye"
  s.add_dependency "rake"
  s.add_dependency "rails", "~> 4.2.5.2"

  s.add_development_dependency "sqlite3"
end
