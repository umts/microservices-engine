# frozen_string_literal: true
#require 'spec_helper'
require 'rails_helper'

describe MicroservicesEngine::V1::DataController, type: :controller do
  # routes { Engine.routes }
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
    get :index, { use_route: :microservices_engine }
    expect(response.status).to be(200)
  end

  # describe 'POST #update' do
  #   it 'renders' do
  #     post :update, @data
  #     expect(response.status).to be(200)
  #   end
  # end

end
