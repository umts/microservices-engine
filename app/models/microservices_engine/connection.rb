# frozen_string_literal: true
require 'net/http'

module MicroservicesEngine
  class Connection < ActiveRecord::Base
    validates :name, :url, :object, presence: true

    def get(path, params = {})
      # Query the endpoint for with `attrs` with requirements `reqs`
      # The local endpoint will programmatically try to do (Model).attr per attr in attrs
      # And return each of those values

      # `reqs` is a hash of requirements to be passed into a `.where` clause (i.e.
      # if `reqs` = {id: 5} for model FieldTrip, then assumed functionality from
      # the endpoint is FieldTrip.where(id: 5), then it will get data from attrs from
      # the results.

      # Example use:
      # (connection object for FieldTrip).get(:trip, [123223, public_trip_stops], {active_only: true})
      # => queries endpoint: uri/123223/public_trip_stops
      # => endpoint finds all FieldTrip objects that are active (param flag)
      # => returns the response if the request was a success

      # Assumption: url is followed by a `/`
      uri = URI.parse(url + path.join('/'))
      uri.query = URI.encode_www_form(params)

      res = Net::HTTP.get_response(uri)
      return res.body if res.is_a?(Net::HTTPSuccess)
    end

    def self.get(resource, path, params = {})
      conn = Connection.where(object: resource.to_s) # Does :abc match "abc"?
      conn.get(path, params) if conn
    end
  end
end
