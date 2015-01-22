require 'json'
require 'pry'

module GoogleMapsResponse
  def self.generate_routes(json)
    file = File.read(json)
    data_hash = JSON.parse(file)
    # binding.pry
    trip = Trip.new(data_hash['routes'][0]['legs'][0]) # need to figure out how to only have this run once
    data_hash['routes'].each do |r|
      route = Route.new(r['legs'][0])
      trip.routes << route
      r['legs'][0]['steps'].each do |s|
        route.steps << Step.new(s)
      end
    end
    p trip
    puts
    p trip.routes
    puts
    trip.routes.each{|r| p r.steps}
  end
end

class Trip
  attr_accessor :routes

  def initialize(args)
    @start_location_lat = args['start_location']['lat']
    @start_location_lng = args['start_location']['lng']
    @end_location_lat = args['end_location']['lat']
    @end_location_lng = args['end_location']['lng']
    @routes = []
  end
end


class Route
  attr_accessor :steps

  def initialize(args)
    @distance = args['distance']['value'] # in meters!!!
    @duration = args['duration']['value'] # in seconds!!!
    @steps = []
  end
end

class Step

  def initialize(args)
    @distance = args['distance']['value'] # in meters!!!
    @duration = args['duration']['value'] # in seconds!!!
    @travel_mode = args['travel_mode'].downcase
  end
end

GoogleMapsResponse.generate_routes('../../doc/google_maps_response_example.json')
