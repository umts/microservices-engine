# frozen_string_literal: true
require 'test_helper'

module MicroservicesEngine
  class DataControllerTest < ActionController::TestCase
    setup do
      @routes = Engine.routes
    end

    before :each do
      @data = {
        'build': 300,
        'token': 'abc',
        'content': [
          {
            'name': 'Endpoint 1',
            'object': 'FieldTrip',
            'url': 'http://example.com/microservices_engine/v1/data'
          },
          {
            'name': 'Endpoint 2',
            'object': 'Survey',
            'url': 'http://potatoes.com/microservices_engine/v1/data'
          }
        ]
      }
    end

    describe 'POST #update' do
      it 'renders' do
        post :update, @data
        expect(response.status).to be(200)
      end
    end
  end
end
