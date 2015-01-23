require pry
class CtaTrainStop < ActiveRecord::Base
  def self.find_nearest_stations(lat, lng)
    distance = 1.0005
    while CtaTrainStop.where("lat < ? AND lng < ? AND lat > ? AND lng > ? ", lat+distance, lng + distance,lat-distance, lng - distance)
      binding.pry
      distance += 0.0005
    end
  end

end
