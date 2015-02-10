class Divvy < ActiveRecord::Base

  scope :radius, ->(lat, lng, distance) {where("lat < ? AND lng < ? AND lat > ? AND lng > ? ", lat+distance, lng + distance,lat-distance, lng - distance)}

  def self.find_stations(lat, lng)
    distance = 0.0005
    count = 0
    while Divvy.radius(lat, lng, distance).count < 4
      distance += 0.0005*Math.exp(count)
      count += 1
    end
    Divvy.radius(lat, lng, distance)
  end

  def self.closest_station(lat,lng)
    stations = Divvy.find_stations(lat,lng)
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
      divvy_location = Divvy.find_by(station_id: station_data[:station_id])
      divvy_location.update(station_data)
    end
  end

  def self.create_stations
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


  def self.distance(miles)
    if miles < 6
      (0.813*(miles)**3 - 5.723*(miles)**2 - 1.547*(miles) + 100).to_i
    else
      50
    end
  end

  def self.cost
      cost = 7
  end

  def self.dollars(factors)
    duration = factors["duration"]
    time_constant = factors["time_constant"]
    actual_cost = factors["actual_cost"]
    money_time_factor = factors["money_time_factor"]
    (100 - (duration*time_constant+actual_cost)*money_time_factor).to_i
  end



end
