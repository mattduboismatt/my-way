class Trip < ActiveRecord::Base
  require './app/modules/google_maps.rb'
  require './app/modules/uber.rb'
  require './app/modules/darksky.rb'
  require './app/algorithms/dollars.rb'
  require './app/algorithms/distance.rb'
  require './app/algorithms/weather.rb'
  require './app/algorithms/safety.rb'
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

  def generate_and_score_routes(current_user, wl)
    all_routes = []
    g_routes = self.google_routes
    forecast = Rails.cache.fetch("forecast", expires_in: 5.minutes) do
      Forecast.new({'lat' => 41.8896848, 'lng' => -87.6377502}) #dev bootcamp!!
    end
    g_routes.each do |gr|
      if gr.travel_mode == 'driving' #driving, uber, cab
        all_routes << Route.google_driving(gr, forecast)
      elsif gr.travel_mode == 'bicycling' #bicycling, divvy
        all_routes << Route.google_bicycling(gr, forecast)
      elsif gr.travel_mode == 'walking'
        all_routes << Route.walking(gr, forecast)
      elsif gr.travel_mode == 'subway'
        all_routes << Route.subway(gr, forecast)
      elsif gr.travel_mode == 'bus'
        all_routes << Route.bus(gr, forecast)
      end
    end
    all_routes.flatten!
    wl = blacklist_all_check(wl)
    routes = strip_blacklisted_routes(all_routes, wl)
    routes.each{ |r| r.apply_user_weightings(current_user) }
    routes.sort_by { |r| r.weighted_exp * -1 }
  end

  def blacklist_all_check(wl)
    if wl.has_value?("1")
      wl
    else
      {"walking"=>"1", "bicycling"=>"1", "divvy"=>"1", "bus"=>"1", "subway"=>"1", "driving"=>"1", "uber"=>"1", "cab"=>"1"}
    end
  end

  def strip_blacklisted_routes(all_routes, wl)
    all_routes.select{ |r| r.is_whitelisted?(wl) }
  end
end
