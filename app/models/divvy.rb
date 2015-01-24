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
    divvy_data['stationBeanList'].each do |station|
    end
  end

  def self.create_hash
      station_data =  Divvy.key_map(station)
      Divvy.create(station.select{ |key, _| Divvy.attribute_keys.include? key })
    end
  end

  def self.attribute_keys
    keys = Divvy.new.attributes.keys
    keys.delete("id")
    keys
  end

  def self.key_map(station)
    mapping = {
      id: :station_id,
      stationName: :station_name,
      availableDocks: :available_docks,
      totalDocks: :total_docks,
      latitude: :lat,
      longitude: :lng,
      statusValue: :status_value,
      availableBikes: :available_bikes,
      location: :address,
      stAddress1: :intersection,
    }
    Hash[station.map {|k, v| [mapping[k], v] }]
  end
end
