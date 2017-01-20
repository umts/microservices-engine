require 'spec_helper'
require 'generators/install/templates/microservices_engine'

describe MicroservicesEngine::Initializer do
  describe 'report_missing_config_key' do
    let(:call) { described_class.report_missing_config_key :key }
    it 'raises an ArgumentError' do
      expect{ call }.to raise_error ArgumentError
    end
  end
end
