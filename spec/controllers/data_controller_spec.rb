# frozen_string_literal: true
require 'spec_helper'

describe MicroservicesEngine::V1::DataController, type: :controller do
  routes { MicroservicesEngine::Engine.routes }
  before(:each) do
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

  it 'works' do
    get :index
    expect(response.status).to be(200)
  end

  #describe 'POST #update' do
  #  it 'renders' do
  #    post :update, @data
  #    expect(response.status).to be(200)
  #  end
  #end

end
