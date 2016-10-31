# frozen_string_literal: true
require 'net/http'

module MicroservicesEngine
  class Connection < ActiveRecord::Base
    validates :name, :url, :object, presence: true

    def self.get(resource, path, params = {})
      conn = Connection.find_by(object: resource.to_s) # Does :abc match "abc"?
      conn.get(path, params) if conn.present?
    end

    def get(path, params = {})
      # Example use:
      # (connection object for FieldTrip).get([123223, public_trip_stops], {active_only: true})
      # => queries endpoint: uri/123223/public_trip_stops
      # => endpoint finds all FieldTrip objects that are active (param flag)
      # => returns the response if the request was a success

      # Assumption: url is followed by a `/`
      uri = URI.parse(url + path.join('/'))
      uri.query = URI.encode_www_form(params)

      res = Net::HTTP.get_response(uri)
      return res.body if res.is_a?(Net::HTTPSuccess)
    end
  end
end
