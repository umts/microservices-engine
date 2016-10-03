# frozen_string_literal: true
module MicroservicesEngine
  class Connection < ActiveRecord::Base
    validates :name, :url, :object, presence: true

    def data(*attributes)
      # TO-DO
      # Send a request to the endpoint in the Connection object
    end

    def self.data(objectName, *attributes)
      conn = Connection.where(object: objectName)
      conn ? conn.data(attributes) : {}
    end

    def get(reqs, attrs)
      # Query the endpoint for with `attrs` with requirements `reqs`
      # The local endpoint will programmatically try to do (Model).attr per attr in attrs
      # And return each of those values

      # `reqs` is a hash of requirements to be passed into a `.where` clause (i.e.
      # if `reqs` = {id: 5} for model FieldTrip, then assumed functionality from
      # the endpoint is FieldTrip.where(id: 5), then it will get data from attrs from
      # the results.

      # Example use:
      # (connection object for FieldTrip).data({active: true, bus: false}, {:id, :cost_estimate})
      # => queries endpoint
      # => endpoint finds all FieldTrip objects that are active and have the bus attribute being false
      # => it then collects the `attrs` and return
    end

    def self.get(options, reqs, attrs = [])
      # VALID USES
        # All possible fields present
        # MicroserviceEngine.get({model: :public_trip_stops, through: :trip}, {id: 130732}, [:active, :id])

        # All optional fields dropped
        # MicroserviceEngine.get({model: :trip}, {active: true})

      # INVALID USES
        # No model specified
        # MicroserviceEngine.get({}, {active: true})

        # Requirements skipped
        # MicroserviceEngine.get({model: :trip}, [:id])

      model = options.fetch(:model) rescue return {}
      through = options.fetch(:through, nil)

      conn = Connection.where(object: through || model)

      attrs = attrs + [model] unless through.nil?
      conn ? conn.get(reqs, attributes) : {}
    end
  end
end
