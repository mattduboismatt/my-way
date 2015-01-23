require 'forecast_io'


class Forecast
  attr_reader :forecast, :lat, :long
  def initialize(args)
    @lat = args["lat"]
    @lng = args["lng"]
    @forecast = ForecastIO.forecast(@lat, @lng)
  end

  def current_precise_temp
    current.temperature
  end

  def current_apparent_temp
    current.apparentTemperature
  end

  def current_humidity
    current.humidity
  end

  def current_wind_speed
    current.windSpeed
  end

  def current_wind_bearing
    deg_to_compass(current.windBearing)
  end

  def current_precip_probability
    current.precipProbability
  end

  def current_precip_intensity
    current.precipIntensity
  end

  def next_hour_precise_temp
    next_hour.temperature
  end

  def next_hour_apparent_temp
    next_hour.apparentTemperature
  end

  def next_hour_humidity
    next_hour.humidity
  end

  def next_hour_wind_speed
    next_hour.windSpeed
  end

  def next_hour_wind_bearing
    deg_to_compass(next_hour.windBearing)
  end

  def next_hour_precip_probability
    current.precipProbability
  end

  def next_hour_precip_intensity
    next_hour.precipIntensity
  end

  def sunrise
    today.sunriseTime
  end

  def sunset
    today.sunsetTime
  end

  private

  def today
    @forecast.daily.data[0]
  end

  def next_hour
    next_hour = hourly_forecast.select do |hour|
      difference = hour_time_difference(hour)
      difference < 3600 && difference > 0
    end
    next_hour[0]
  end

  def current
    forecast.currently
  end

  def hourly_forecast
    @forecast.hourly.data
  end

  def current_time_unix
    Time.now.to_i
  end

  def hour_time_difference(hour)
    hour.time - current_time_unix
  end

  def deg_to_compass(num)
    val=((num/22.5)+0.5).to_i
    arr=["N","NNE","NE","ENE","E","ESE", "SE", "SSE","S","SSW","SW","WSW","W","WNW","NW","NNW"]
    arr[(val % 16)]
  end

end
