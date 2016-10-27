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
    stub_request(:get, @conn.url + @path.join('/'))
      .with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Host'=>'example.com', 'User-Agent'=>'Ruby'})
      .to_return(:status => 200, :body => "", :headers => {})
  end

  describe 'self.get' do
    # it 'implies params' do
    #   expect(@conn).to receive(:get).with(@path, {})
    #   resp = MicroservicesEngine::Connection.get('ExampleModel', @path)
    # end
  end
end
