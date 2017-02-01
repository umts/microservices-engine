# frozen_string_literal: true
require 'rails/generators/active_record'
class InstallGenerator < ActiveRecord::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  def setup_initializer
    template 'mse_router_info.yml', 'config/mse_router_info.yml'
    copy_file 'microservices_engine.rb',
              'config/initializers/microservices_engine.rb'
    # migration_template 'create_microservices_engine_connections.rb',
    #                    'db/migrate/create_microservices_engine_connections.rb',
    #                    migration_version: migration_version
  end

  # idea for this is from the 'devise' gem by plataformatec
  #def migration_version
    #if Rails::VERSION::MAJOR >= 5
      #"[#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}]"
    #end
  #end

end
