require 'json'
require 'pry'
require 'uri'
require 'awesome_print'
require 'securerandom'
# API_KEY = ENV["GOOGLE_MAP_API_KEY"]
# request = https://maps.googleapis.com/maps/api/directions/json? + parameters

module GoogleMaps

  def self.build_uri(a,b,mode)
    uri = URI::HTTPS.build({
      host: 'maps.googleapis.com',
      path: '/maps/api/directions/json',
      query: URI.encode_www_form(
        origin: a,
        destination: b,
        mode: mode,
        alternatives: 'true',
        region: 'us',
        key: ENV["GOOGLE_MAP_API_KEY"]
      )
    })
  end

  def self.generate_trip(json, trip=nil)
    data = JSON.parse(json)
    if trip
      data['routes'].each {|r| trip.add_route(r)}
    else
      trip = Trip.new(data)
    end
    trip
  end
end

class GoogleThing
  attr_reader :id
  def initialize(*args)
    @id = SecureRandom.uuid
  end
end

class Trip < GoogleThing
  attr_reader :origin, :destination, :routes

  def initialize(trip_data)
    super
    first_leg = trip_data['routes'][0]['legs'][0]
    @origin = first_leg['start_location']
    @destination = first_leg['end_location']
    @routes = []
    trip_data['routes'].each {|r| add_route(r)}
  end

  def add_route(route_data)
    @routes << Route.new(route_data['legs'][0])
  end
end


class Route < GoogleThing
  attr_reader :distance, :duration, :steps

  def initialize(route_data)
    super
    @distance = route_data['distance']['value'] # in meters!!!
    @duration = route_data['duration']['value'] # in seconds!!!
    @steps = []
    route_data['steps'].each {|s| add_step(s)}
  end

  def add_step(step_data)
    @steps << Step.new(step_data)
  end
end

class Step < GoogleThing
  attr_reader :distance, :duration, :travel_mode

  def initialize(step_data)
    super
    @distance = step_data['distance']['value'] # in meters!!!
    @duration = step_data['duration']['value'] # in seconds!!!
    @travel_mode = step_data['travel_mode'].downcase
  end
end
