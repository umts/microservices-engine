# frozen_string_literal: true
require 'rails_helper'

describe MicroservicesEngine::Connection do
  before(:each) do
    @conn = MicroservicesEngine::Connection.create(
      name: 'Connection 1',
      url: 'http://example.com/',
      object: 'ExampleModel'
    )
    @path = %w(test tset)
    @full_path = ([@conn.object] + @path).join('/')
    stub_request(:get, @conn.url + @full_path)
      .with(headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'Host' => 'example.com',
              'User-Agent' => 'Ruby'
            })
      .to_return(status: 200, body: 'response_body_here', headers: {})
  end

  describe 'self.get' do
    it 'implies params' do
      expect_only_instance_of(MicroservicesEngine::Connection).to receive(:get).with(@full_path, {})
      MicroservicesEngine::Connection.get('ExampleModel', @path)
    end

    it 'returns the response body' do
      expect(MicroservicesEngine::Connection.get('ExampleModel', @path)).to be('response_body_here')
    end
  end

  describe 'get' do
    it 'returns the response body' do
      expect(@conn.get(@full_path)).to be('response_body_here')
    end
  end
end
