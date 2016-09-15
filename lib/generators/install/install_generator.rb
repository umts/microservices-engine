class InstallGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  argument :objects, :type => :string, default: "b"

  def setup_initializer
    split_objs = objects.split(',')
    print(
          "The following objects are being added to the initializer:
          #{split_objs.join(', ')}\n\n"
          )

    # Preparing the dynamic object loading file
    inner_portion = ""
    split_objs.each do |obj|
      inner_portion += "config.endpoint_models << #{obj}\n"
    end

    print('1')

    file_content = "MicroservicesEngine.configure do |config|
      #{inner_portion}
      end"

    print('2')

    # Writing the dynamic object loading file
    create_file "config/initializers/microservices_engine.rb", <<-FILE
    #{file_content}
    FILE
  end
end
