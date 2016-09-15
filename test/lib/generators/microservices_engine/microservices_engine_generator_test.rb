require 'test_helper'
require 'generators/microservices_engine/microservices_engine_generator'

module MicroservicesEngine
  class MicroservicesEngineGeneratorTest < Rails::Generators::TestCase
    tests MicroservicesEngineGenerator
    destination Rails.root.join('tmp/generators')
    setup :prepare_destination

    # test "generator runs without errors" do
    #   assert_nothing_raised do
    #     run_generator ["arguments"]
    #   end
    # end
  end
end
