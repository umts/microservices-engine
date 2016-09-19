require_dependency "microservices_engine/application_controller"

module MicroservicesEngine
  module V1
    class DataController < ApplicationController
      def update
        # TO-DO
        # . . .

        token = params.require(:token)
        # TO-DO
        #
        # Add logic to verify token, perhaps send a request to the router
        # to ask if the token is valid?

        data = params.require(:content)
        # TO-DO
        #
        # Generate connection objects / update existing connection objects
        # based on the contents of the request.
        #
        # Requires knowledge of how the router will send data to engines
        # so this will be delayed
      end
    end
  end
end
