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

  describe 'check_in_with_router' do
    let :data do
      { 'name' => 'service_name',
        'uri' => 'service_url',
        'router_uri' => 'http://example.com',
        'security_token' => 'security token' }
    end
    let(:call){ described_class.check_in_with_router using: data }
    it 'makes a Net::HTTP POST request and returns the response' do
      expect(Net::HTTP).to receive(:post_form).and_return 'some response'
      expect(call).to eql 'some response'
    end
    it 'sends the request to the provided router_uri + /services/register' do
      router_address = data['router_uri']
      endpoint_address = router_address + '/services/register'
      endpoint_uri = URI.parse(endpoint_address)
      expect(Net::HTTP).to receive(:post_form).with endpoint_uri, anything
      call
    end
    it 'includes the service name, url, and security token in the params' do
      expected_params = { name: data['name'], url: data['uri'],
                          security_token: data['security_token'] }
      expect(Net::HTTP).to receive(:post_form)
        .with anything, hash_including(expected_params)
      call
    end
    it 'includes any accessible models, if they exist' do
      data['accessible_models'] = 'apples, bananas'
      expect(Net::HTTP).to receive(:post_form)
        .with anything, hash_including(models: 'apples, bananas')
      call
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
