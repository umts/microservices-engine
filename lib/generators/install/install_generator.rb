class InstallGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  def setup_initializer
    template "mse_router_info.yml", "config/mse_router_info.yml"
    copy_file "microservices_engine.rb",
      "config/initializers/microservices_engine.rb"
  end
end
