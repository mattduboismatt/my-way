class Divvy < ActiveRecord::Base
  require 'uri'
  require "net/http"

  require 'json'

  def self.build_uri
    host = 'www.divvybikes.com'
    path = '/stations/json'
    URI::HTTPS.build(host: host, path: path)
  end

  def self.response
    res = Net::HTTP.get(Divvy.build_uri)
    JSON.parse(res)
  end

  def self.update_stations
    divvy_data = Divvy.response
    divvy_data['stationBeanList'].each do |station|
      station_data = Divvy.key_map(station)
      Divvy.create(station_data)
    end
  end


  def self.key_map(station)
    mapping = {
      "id" => :station_id,
      "stationName" => :station_name,
      "availableDocks"=> :available_docks,
      "totalDocks" => :total_docks,
      "latitude"=> :lat,
      "longitude"=> :lng,
      "statusValue" => :status_value,
      "availableBikes"=> :available_bikes,
      "location" => :address
    }
    station.delete("lastCommunicationTime")
    station.delete("testStation")
    station_data = Hash[station.map {|k, v| [mapping[k], v] }]
    station_data.delete(nil)
    station_data
  end
end
