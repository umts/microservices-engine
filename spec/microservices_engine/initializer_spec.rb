require 'spec_helper'
require 'generators/install/templates/microservices_engine'

describe MicroservicesEngine::Initializer do
  describe 'report_missing_config_key' do
    let(:call) { described_class.report_missing_config_key :bananas }
    it 'raises an ArgumentError' do
      expect{ call }.to raise_error ArgumentError
    end
    it 'includes the missing key in the exception' do
      expect{ call }.to raise_error ArgumentError, /bananas/
    end
    it 'includes the location of the config file in the exception' do
      stub_const 'MicroservicesEngine::Initializer::CONFIG_FILE', 'apples'
      expect{ call }.to raise_error ArgumentError, /apples/
    end
  end
end
