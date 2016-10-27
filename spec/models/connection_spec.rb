# frozen_string_literal: true
require 'rails_helper'

describe MicroservicesEngine::Connection do
  before(:each) do
    @conn = MicroservicesEngine::Connection.create(
      name: 'Connection 1',
      url: 'http://example.com',
      object: 'ExampleModel'
    )
  end

  describe 'self.get' do
    # it 'implies params' do
    #   expect(@conn).to receive(:get).with(%w(test tset), {})
    #   MicroservicesEngine::Connection.get('ExampleModel', %w(test tset))
    # end
  end
end
