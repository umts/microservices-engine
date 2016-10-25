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
    @changed_data = @data.deep_dup # A version of data that is changed for tests
  end

  describe 'POST #register' do
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

        @changed_data['token'] = 'mayonaise_is_not_an_instrument_patrick'
        expect { post :register, @changed_data }.to raise_error(SecurityError)
      end
    end

    # The request updates the build version properly
    describe 'updating MicroservicesEngine.build' do
      context 'failing builds' do
        failing_builds = [0, -1].repeated_permutation(3).to_a.map { |bld| relative_build(*bld) }
        failing_builds -= ['1.1.1'] # this is a result of above but is a valid build

        failing_builds.each do |failing_build|
          it 'fails with older version #{failing_build}' do
            change_build(failing_build, @changed_data)
            expect { post :register, @changed_data }.to raise_error(RuntimeError)
          end
        end
      end

      context 'passing builds' do
        passing_builds = [0, 1].repeated_permutation(3).to_a.map { |bld| relative_build(*bld) }

        passing_builds.each do |passing_build|
          it 'passes with newer version #{passing_build}' do
            change_build(passing_build, @changed_data)
            expect(MicroservicesEngine.build).to eq('1.1.1')
            post :register, @changed_data
            expect(MicroservicesEngine.build).to eq(passing_build)
          end
        end
      end
    end

    # The request generates, modifies, and removes Connection
    # objects as expected
    describe 'resulting Connection models' do
      before(:each) do
        @extract = ->(d, key) { d[:content].collect { |c| c[key.to_sym] } }
        @connection = MicroservicesEngine::Connection
      end

      context 'before the request' do
        it 'has no objects' do
          expect(@connection.count).to be(0)
        end
      end

      describe 'new' do
        before(:each) do
          post :register, @data
        end

        it 'generates the models' do
          expect(@connection.count).to be(2)
        end

        it 'generated the names' do
          expect(@connection.all.map(&:name)).to eq(@extract.call(@data, :name))
        end

        it 'generated the urls' do
          expect(@connection.all.map(&:url)).to eq(@extract.call(@data, :url))
        end

        it 'generated the objects' do
          expect(@connection.all.map(&:object)).to eq(@extract.call(@data, :object))
        end

        # TODO
        it 'generates new model when object changes' do
          @changed_data[:content][0][:object] = 'SomeOtherObject'
          expect { post :register, @changed_data }
            .to change { @connection.count }
            .by(1)
        end

        it 'adds model when new data appears' do
          new_data = {
            'name': 'Endpoint 2',
            'object': 'Potatoes',
            'url': 'pota://toe.sareawes.ome'
          }
          @changed_data[:content].append(new_data)

          expect { post :register, @changed_data }
            .to change { @connection.count }
            .by(1)
        end

        it 'ignores generation with empty url' do
          new_data = {
            'name': 'Endpoint 2',
            'object': 'Potatoes',
            'url': ''
          }
          @changed_data[:content].append(new_data)

          expect { post :register, @changed_data }
            .not_to change { @connection.count }
        end
      end

      describe 'editing' do
        before(:each) do
          post :register, @data
        end

        it 'updates the name' do
          @changed_data[:content][0][:name] = 'Potatoes'
          expect { post :register, @changed_data }
            .to change { @connection.all.map(&:name) }
            .from(@extract.call(@data, :name))
            .to(@extract.call(@changed_data, :name))
        end

        it 'updates the url' do
          @changed_data[:content][0][:url] = 'pota://toe.s/'
          expect { post :register, @changed_data }
            .to change { @connection.all.map(&:url) }
            .from(@extract.call(@data, :url))
            .to(@extract.call(@changed_data, :url))
        end

        # Changing the `object` link will not modify an
        # existing object. It will create a new one.
      end

      # TODO
      # (setting url to '')
      describe 'removing' do
        before(:each) do
          post :register, @data
        end

        it 'removes the model' do
          @changed_data[:content][0][:url] = ''
          expect { post :register, @changed_data }
            .to change { @connection.count }
            .by(-1)
        end
      end
    end
  end
end
