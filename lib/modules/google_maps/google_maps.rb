require 'json'
require 'pry'
require 'uri'
require 'awesome_print'
require 'securerandom'
require 'pry'
require 'net/http'
# API_KEY = ENV["GOOGLE_MAP_API_KEY"]
# request = https://maps.googleapis.com/maps/api/directions/json? + parameters

module GoogleMaps

  def self.run(trip)
    modes = ["driving","walking","bicycling","transit"]
    modes.each do |m|
      req = self.build_uri(trip.origin.address,trip.destination.address,m)
      res = Net::HTTP.get(req)
      GoogleMaps.generate_trip(res, trip)
    end
  end

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

class GoogleTrip < GoogleThing
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


class GoogleRoute < GoogleThing
  attr_reader :distance, :duration, :steps, :travel_mode

  def initialize(route_data)
    super
    @distance = route_data['distance']['value'] # in meters!!!
    @duration = route_data['duration']['value'] # in seconds!!!
    @steps = []
    route_data['steps'].each {|s| add_step(s)}
    @travel_mode = self.set_travel_mode
  end

  def add_step(step_data)
    @steps << Step.new(step_data)
  end

  def set_travel_mode
    modes = self.steps.map{|s| s.travel_mode }
    if modes.include?('driving')
      'driving'
    elsif modes.include?('bicycling')
      'bicycling'
    elsif modes.include?('transit')
      'transit'
    else
      'walking'
    end
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
