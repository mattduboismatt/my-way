require 'pry'
class CtaTrainStop < ActiveRecord::Base
  def self.find_stations(lat, lng)
    distance = 1.0005
    CtaTrainStop.where("lat < ? AND lng < ? AND lat > ? AND lng > ? ", lat+distance, lng + distance,lat-distance, lng - distance)
  end

  def self.closest_station(lat,lng)
    stations = CtaTrainStop.find_stations(lat,lng)
    lat_dif = (stations.first.lat - lat).abs
    lng_dif = (stations.first.lng - lng).abs
    closest_station = stations.first
    stations.each do |station|
      if (station.lat - lat).abs <= lat_dif && (station.lng - lng).abs <= lng_dif
        lat_dif = (station.lat - lat).abs
        lng_dif = (station.lng - lng).abs
        closest_station = station
      end
    end
    closest_station
  end
end
