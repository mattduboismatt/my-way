class Trip < ActiveRecord::Base
  require './app/modules/google_maps.rb'
  require './app/modules/uber.rb'
  require './app/modules/darksky.rb'
  require './app/algorithms/dollars.rb'
  require './app/algorithms/distance.rb'
  require './app/algorithms/duration.rb'
  require './app/algorithms/weather.rb'
  require 'forecast_io'


  belongs_to :user
  has_one :origin, class_name: 'Location'
  has_one :destination, class_name: 'Location'
  has_many :routes

  def set_origin(origin_str, user)
    self.origin = Location.new(address: origin_str, user: user)
  end

  def set_destination(destination_str, user)
    self.destination = Location.new(address: destination_str, user: user)
  end

  def google_routes
    GoogleMaps.run(self)
  end

  def generate_and_score_routes
    routes = []
    g_routes = self.google_routes
    forecast = Forecast.new(g_routes[0].origin)
    g_routes.each do |gr|
      if gr.travel_mode == 'driving' #driving, uber, cab
        routes << Route.google_driving(gr, forecast)
      elsif gr.travel_mode == 'bicycling' #bicycling, divvy
        routes << Route.google_bicycling(gr, forecast)
      else # subway, bus, walking
        routes << Route.google_transit_and_walking(gr, forecast)
      end
    end
    routes.flatten!
    routes.sort_by { |r| r.total_exp * -1 }
  end
end
