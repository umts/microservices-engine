# frozen_string_literal: true
require_dependency 'microservices_engine/application_controller'

module MicroservicesEngine
  module V1
    class DataController < ApplicationController
      def register
        # TO-DO
        # . . .

        # Current assumption of example request format
        #
        # {
        #     'build': 1.0.0,
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

        verify_token(params['token'])
        verify_build(params['build'])

        data = params['content']
        if data.present?
          data.each do |endpoint|
            existing = Connection.where(object: endpoint['object']).first
            if existing.present?
              if endpoint['url'].present?
                # URL exists so we will update as usual
                existing.update_attributes(
                  name: endpoint.require(:name),
                  url: endpoint.require(:url)
                )
              else
                # URL is blank, thus the endpoint no longer exists
                # Thus, we will remove the object as to avoid confusion
                Connection.destroy(existing.id)
              end
            elsif endpoint['url'].present?
              new_connection = Connection.create(
                name: endpoint.require(:name),
                url: endpoint.require(:url),
                object: endpoint.require(:object)
              )
            end
          end
        end

        render json: { 'response': 200 }, status: :ok
      end

      private

      def verify_token(token)
        raise SecurityError, '(Stub) Invalid Token' unless MicroservicesEngine.valid_token?(token)
      end

      def verify_build(build)
        # The build= method already has verification built-in
        MicroservicesEngine.build = build
      end
    end
  end
end
