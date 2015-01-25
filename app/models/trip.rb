require './app/lib/modules/google_maps/google_maps.rb'
require './app/lib/algorithms/dollars.rb'
require './app/lib/algorithms/distance.rb'
require './app/lib/algorithms/duration.rb'
require './app/lib/algorithms/weather_algorithm.rb'

class Trip < ActiveRecord::Base


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
    binding.pry
    GoogleMaps.run(self)
  end

  def generate_and_score_routes
    self.google_routes.each do |gr|
      r = Route.new(travel_mode: gr.travel_mode, trip: self)
      r.distance_exp = DistanceAlgorithm.run(gr)
      r.duration_exp = DurationAlgorithm.run(gr)
      r.dollars_exp = DollarsAlgorithm.run(gr)
      # r.weather_exp = Weather.run(gr)
    end
    # something for uber
    # something for cab
    # something for divvy
    # trip.routes would give routes with mode and exp only
  end
end
