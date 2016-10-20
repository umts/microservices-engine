# frozen_string_literal: true
require 'rails_helper'

# PLANNED FOR MOVE TO OTHER FILE
def change_build(v, b)
  b['build'] = v
end

def relative_build(ma, mi, r)
  [ma, mi, r].map { |ver| 1 + ver }.join('.')
end
# PLANNED FOR MOVE TO OTHER FILE

describe MicroservicesEngine::V1::DataController, type: :controller do
  routes { MicroservicesEngine::Engine.routes }
  def setup
    @routes = MicroservicesEngine::Engine.routes
  end

  before(:each) do
    MicroservicesEngine.build = '1.1.1'
    @data = {
      'build': '1.1.2',
      'token': 'TEST_ENV_VALID_TOKEN',
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
    it 'responds' do
      post :register, @data
      expect(response.status).to be(200)
    end

    # Validating tokens
    describe 'validating token' do
      it 'accepts valid token' do
        # 1. Expect submitting the data to not cause any issues

        expect { post :register, @data }.not_to raise_error
      end

      it 'denies invalid token' do
        # 1. Change base data to be an invalid token
        # 2. Expect the request to cause an error.

        @data['token'] = 'mayonaise_is_not_an_instrument_patrick'
        expect { post :register, @data }.to raise_error(SecurityError)
      end
    end

    describe 'updating MicroservicesEngine.build' do
      context 'failing builds' do
        failing_builds = [0, -1].repeated_permutation(3).to_a.map { |bld| relative_build(*bld) }
        failing_builds -= ['1.1.1'] # this is a result of above but is a valid build

        failing_builds.each do |failing_build|
          it 'fails with older version #{failing_build}' do
            change_build(failing_build, @data)
            expect { post :register, @data }.to raise_error(RuntimeError)
          end
        end
      end

      context 'passing builds' do
        passing_builds = [0, 1].repeated_permutation(3).to_a.map { |bld| relative_build(*bld) }

        passing_builds.each do |passing_build|
          it 'passes with newer version #{passing_build}' do
            change_build(passing_build, @data)
            expect(MicroservicesEngine.build).to eq('1.1.1')
            post :register, @data
            expect(MicroservicesEngine.build).to eq(passing_build)
          end
        end
      end
    end
  end
end
