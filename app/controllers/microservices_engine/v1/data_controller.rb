require_dependency "microservices_engine/application_controller"

module MicroservicesEngine
  module V1
    class DataController < ApplicationController

      def index
        # REST Endpoint
        # Used to retrieve data from the local application
        # Usage: http://(url)/data?models={MODELS}
        #        MODELS: A set of model names to request data of separated
        #                by commas.
        # Example: http://larrysenior.com/data?models=ChewingGum,LarrysKid

        objs = params.require(:models) #.permit(:attributes)

        models = objs.split(',')
        # if objs['attributes']
        #   attrs = objs['attributes'].split(',')
        # end

        valid_model_names = MicroservicesEngine.config.endpoint_models.map{|mdl| mdl.name}

        if models.all? { |param| param.in? valid_model_names }
          content = {}
          models.each do |mdl|
            content[mdl] ||= []

            mdl.constantize.all.each do |m_obj|
              content[mdl] << m_obj.attributes
            end
          end
          render json: {
            'response': 200,
            'content': content
          }
        else
          render json: {
            'response': 404,
            'content': 'One or more of the requested models are not available here'
          }
        end
      end

      def update
        # TO-DO
        # . . .
      end
    end
  end
end
