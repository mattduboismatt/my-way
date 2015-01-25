module WeatherAlgorithm
  def self.run(route)
    Weather.new(route).score
  end
end

class Weather
  require './app/lib/modules/darksky/darksky.rb'
  require 'forecast_io'

  def initialize(route)
    @origin = route.origin || nil
    @destination = route.destination || nil
    @mode = route.travel_mode
    @forecast = Forecast.new({ "lat"=> @origin["lat"], "lng"=> @origin["lng"] })
  end

  def score
    (precip_score+app_temp_score+wind_speed_score)/3
  end




  def precip_score
    precip_stored_scores[@mode]
  end

  def app_temp_score
    return @mode == "bicycling" || @mode == "walking" ? walk_bike_app_temp_score : 90
  end

  def wind_speed_score
    wind_score = wind_speed_stored_scores[@mode]
    score= wind_score <= 60 ? (wind_score * wind_bearing_score) : wind_score
    score.to_i
  end




  def walk_bike_app_temp_score
    temp = @forecast.current_apparent_temp
    lower_temp_score = (-0.0178*(temp - 0)*(temp - 115)).to_i
    higher_temp_score = (-0.0625*(temp - 35)*(temp - 115)).to_i
    return temp <= 75 ? lower_temp_score : higher_temp_score
  end

  def driving_precip_score
    p_score = @forecast.next_hour_precip_intensity
    return 100                                        if p_score < 15
    return (99 - 10*((p_score-15).to_f/15.0)).ceil    if p_score < 30
    return (89 - 89*((p_score-30).to_f/35.0)).ceil    if p_score < 65
    return 0
  end

  def walk_bike_precip_score
    p_score = @forecast.next_hour_precip_intensity
    reverse_p_score = 100 - 100*(p_score.to_f/50.0)
    return p_score < 50 ? reverse_p_score.to_i : 0
  end

  def precip_stored_scores
    {
      "walking" => walk_bike_precip_score,
      "bicycling" => walk_bike_precip_score,
      "driving" => driving_precip_score,
      "bus" => driving_precip_score,
      "train" => driving_precip_score,
      "cab" => driving_precip_score,
      "uber" => driving_precip_score
    }
  end

  def wind_bearing_score
    bearing_score = (bearing_difference.to_f/180.0).round(3)
    return @mode == "walking" || @mode == "bicycling" ? bearing_score : 1.0
  end

  def wind_speed_stored_scores
    {
      "walking" => walk_bike_wind_speed,
      "bicycling" => walk_bike_wind_speed,
      "driving" => driving_wind_speed,
      "bus" => driving_wind_speed,
      "train" => driving_wind_speed,
      "cab" => driving_wind_speed,
      "uber" => driving_wind_speed
    }
  end

  def walk_bike_wind_speed
    beaufort = beaufort_number
    return 0      if beaufort > 6
    return 100    if beaufort == 0
    return 96     if beaufort == 1
    return 88     if beaufort == 2
    return 76     if beaufort == 3
    return 60     if beaufort == 4
    return 40     if beaufort == 5
    return 16     if beaufort == 6
  end

  def driving_wind_speed
    beaufort = beaufort_number
    return 100    if beaufort < 8
    return 50     if beaufort == 8
    return 0      if beaufort > 8
  end

  def beaufort_number
    wind = @forecast.current_wind_speed
    ((wind/0.836)**(2/3.0)).to_i
  end

  def bearing_difference
    angle = (route_bearing - wind_bearing).abs%360
    return angle > 180 ? 360 - angle : angle
  end

  def route_bearing
    bearing_squared = (@origin["lat"] + @destination["lat"])**2 + (@origin["lng"] + @destination["lng"])**2
    bearing = Math.sqrt(bearing_squared)
    return bearing%1 < 0.5 ? bearing.floor : bearing.ceil
  end

  def wind_bearing
    @forecast.current_wind_bearing_degrees
  end
end
