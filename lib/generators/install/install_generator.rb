# frozen_string_literal: true
require 'rails/generators/active_record'
class InstallGenerator < ActiveRecord::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  def setup_initializer
    template 'mse_router_info.yml', 'config/mse_router_info.yml'
    copy_file 'microservices_engine.rb',
              'config/initializers/microservices_engine.rb'
    generate 'migration', 'CreateMicroservicesEngineConnection name:string object:string url:string'
    open('.gitignore', 'a') do |ignore|
      ignore.puts('config/mse_router_info.yml')
    end
  end
end
