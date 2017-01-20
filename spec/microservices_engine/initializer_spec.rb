require 'spec_helper'
require 'generators/install/templates/microservices_engine'

describe MicroservicesEngine::Initializer do
  describe 'check_for_config_file!' do
    let(:filepath) { 'some_filepath' }
    let(:call) { described_class.check_for_config_file! filepath }
    it 'looks for a file at the given path' do
      expect(File).to receive(:file?).with(filepath).and_return true
      call
    end
    it "raises an IOError if it can't find one" do
      expect(File).to receive(:file?).with(filepath).and_return false
      expect { call }.to raise_error IOError
    end
    it 'includes the filepath in the exception' do
      expect(File).to receive(:file?).with(filepath).and_return false
      expect { call }.to raise_error IOError, /#{filepath}/
    end
  end

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
