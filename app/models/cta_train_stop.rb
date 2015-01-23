class CtaTrainStop < ActiveRecord::Base
  def self.find_nearest_station(lat, lng, dist)
    distance = dist
    CtaTrainStop.where("lat < ? AND lng < ? AND lat > ? AND lng > ? ", lat+distance, lng + distance,lat-distance, lng - distance)
  end

end
