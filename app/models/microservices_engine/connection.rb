# frozen_string_literal: true
require 'net/http'

module MicroservicesEngine
  class Connection < ActiveRecord::Base
    validates :url, :object, presence: true

    def self.get(resource, path, params = {})
      # examples: resource: :trips, path: [:generate_random_trips]
      conn = Connection.find_by(object: resource.to_s) # Does :abc match "abc"?
      full_path = path.unshift(resource).join('/')
      # full path = 'trips/generate_random_trips'
      if conn.present?
        conn.get full_path, params
      else raise ArgumentError, "Unknown resource #{resource}"
      end
    end

    def get(full_path, params = {})
      # Example use:
      # (connection object for FieldTrip).get([123223, public_trip_stops], {active_only: true})
      # => queries endpoint: uri/123223/public_trip_stops
      # => endpoint finds all FieldTrip objects that are active (param flag)
      # => returns the response if the request was a success

      # Assumption: url is followed by a `/`
      uri = URI.parse(url + full_path)
      uri.query = URI.encode_www_form(params)

      res = Net::HTTP.get_response(uri)
      if res.is_a? Net::HTTPSuccess
        res.body
      else raise ArgumentError, res.body
      end
    end
  end
end
