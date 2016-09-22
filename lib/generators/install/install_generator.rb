class InstallGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
<<<<<<< HEAD

  def setup_initializer
    template "mse_router_info.yml", "config/mse_router_info.yml"
    copy_file "microservices_engine.rb",
      "config/initializers/microservices_engine.rb"
=======
  argument :objects, type: :string, default: 'b'

  def setup_initializer
    # TO-DO

    # Replace the content of this method with the logic for the new
    # install initializer as depicted on the GitHub issue #5
>>>>>>> master
  end
end
