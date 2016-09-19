class InstallGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  argument :objects, :type => :string, default: "b"

  def setup_initializer
    # TO-DO
    
    # Replace the content of this method with the logic for the new
    # install initializer as depicted on the GitHub issue #5
  end
end
