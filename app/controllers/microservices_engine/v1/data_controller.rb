# frozen_string_literal: true
require_dependency 'microservices_engine/application_controller'

module MicroservicesEngine
  module V1
    class DataController < ApplicationController
      def update
        # TO-DO
        # . . .

        # Current assumption of example request format
        #
        # {
        #     'build': 374,
        #     'token': 'a72!j*^bQ34dE%SS$#haBd%67#cD',
        #     'content': {
        #       {
        #         'name': 'Endpoint 1'
        #         'object': 'FieldTrip'
        #         'url': 'http://example.com/microservices_engine/v1/data'
        #       },
        #       {
        #         'name': 'Endpoint 2'
        #         'object': 'Survey'
        #         'url': 'http://potatoes.com/microservices_engine/v1/data'
        #       }
        #     }
        # }
        #

        build = params['build']
        # TO-DO
        #
        # Add logic that will store the Build value in the engine
        # likely using a mattr_accessor

        token = params['token']
        # TO-DO
        #
        # Add logic to verify token, perhaps send a request to the router
        # to ask if the token is valid?

        data = params['content']
        if data.present?
          data.each do |endpoint|
            existing = Connection.where(object: endpoint['object'])
            if existing
              if endpoint['url']
                # URL exists so we will update as usual
                existing.update_attributes(name: endpoint['name'], url: endpoint['url'])
              else
                # URL is blank, thus the endpoint no longer exists
                # Thus, we will remove the object as to avoid confusion
                Connection.destroy(existing)
              end
            else
              new_connection = Connection.create(data)
            end
          end
        end
      end
    end
  end
end
