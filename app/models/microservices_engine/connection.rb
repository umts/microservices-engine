# frozen_string_literal: true
require 'net/http'

module MicroservicesEngine
  class Connection < ActiveRecord::Base
    validates :url, :object, presence: true

    def self.get(resource, path, params = {}, token)
      conn = Connection.find_by(object: resource.to_s) # Does :abc match "abc"?

      # resource is :trips, path is [:generate_random_trips]
      full_path = path.unshift(resource).join('/')
      # full path = 'trips/generate_random_trips'

      raise ArgumentError, "Unknown resource #{resource}" unless conn.present?
      conn.get full_path, params, token
    end

    def get(full_path, params = {}, token)
      # Example use:
      # (connection object for FieldTrip).get([123223, public_trip_stops], {active_only: true})
      # => queries endpoint: uri/123223/public_trip_stops
      # => endpoint finds all FieldTrip objects that are active (param flag)
      # => returns the response if the request was a success

      # Assumption: url is followed by a `/`
      uri = URI.parse(url + full_path)
      uri.query = URI.encode_www_form(params)

      request = Net::HTTP::Get.new(uri.path)
      request.add_field 'Authorization', token
      response = Net::HTTP.new(uri.host, uri.port).start do |http|
        http.request request
      end

      raise ArgumentError, response.body unless response.is_a? Net::HTTPSuccess
      response.body
    end
  end
end
