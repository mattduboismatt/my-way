class Route
  attr_reader :travel_mode
  attr_accessor :distance_exp, :duration, :dollars_exp, :weather_exp, :safety_exp, :comfort_exp, :weighted_exp, :actual_cost
  def initialize(args)
    @travel_mode = args[:travel_mode]
    @distance_exp = 0
    @dollars_exp = 0
    @weather_exp = 0
    @safety_exp = 0
    @comfort_exp = 0
    @weighted_exp = 0
    @actual_cost = 0.to_f
    @duration = 0
  end

  def apply_user_weightings(user)
    if user
      distance_multiplier = user.distance_multiplier
      dollars_multiplier = user.dollars_multiplier
      weather_multiplier = user.weather_multiplier
      safety_multiplier = user.safety_multiplier
    else
      distance_multiplier = 1.0
      dollars_multiplier = 1.0
      weather_multiplier = 1.0
      safety_multiplier = 1.0
    end
    @weighted_exp = (distance_multiplier*@distance_exp) + (dollars_multiplier*@dollars_exp) + (weather_multiplier*@weather_exp) + (safety_multiplier*@safety_exp)
  end

  def is_whitelisted?(wl)
    mode = self.travel_mode
    if wl[mode] == "1"
      true
    else
      false
    end
  end

  def calculate_and_set_all_exp(route_data, forecast)
    @distance_exp = DistanceAlgorithm.run(route_data)
    @actual_cost = DollarsAlgorithm.actual_cost(route_data)
    @dollars_exp = DollarsAlgorithm.run(route_data, @actual_cost)
    @weather_exp = WeatherAlgorithm.run(route_data, forecast)
    @safety_exp = SafetyAlgorithm.run(route_data.travel_mode)
  end

  def self.google_driving(route, forecast)
    uber_res = UberParser.run(route)
    [driving(route, forecast), uber(uber_res, forecast), cab(route, uber_res, forecast)]
  end

  def self.google_bicycling(route, forecast)
    [bicycling(route, forecast), divvy(route, forecast)]
  end

  def self.driving(route, forecast)
    driving_route = Route.new(travel_mode: route.travel_mode)
    driving_route.duration = route.duration*traffic_multiplier
    driving_route.calculate_and_set_all_exp(route, forecast)
    driving_route
  end

  def self.walking(route, forecast)
    walking_route = Route.new(travel_mode: route.travel_mode)
    walking_route.duration = route.duration
    walking_route.calculate_and_set_all_exp(route, forecast)
    walking_route
  end

  def self.subway(route, forecast)
    subway_route = Route.new(travel_mode: route.travel_mode)
    subway_route.duration = route.duration #delays?
    subway_route.calculate_and_set_all_exp(route, forecast)
    subway_route
  end

  def self.bus(route, forecast)
    bus_route = Route.new(travel_mode: route.travel_mode)
    bus_route.duration = route.duration*traffic_multiplier
    bus_route.calculate_and_set_all_exp(route, forecast)
    bus_route
  end

  def self.bicycling(route, forecast)
    bicycling_route = Route.new(travel_mode: route.travel_mode)
    bicycling_route.duration = route.duration
    bicycling_route.calculate_and_set_all_exp(route, forecast)
    bicycling_route
  end

  def self.uber(uber_res, forecast)
    uber_route = Route.new(travel_mode: 'uber')
    uber_route.duration = uber_res.wait_time + uber_res.duration*traffic_multiplier
    uber_route.calculate_and_set_all_exp(uber_res, forecast)
    uber_route
  end

  def self.cab(route, uber_res, forecast)
    cab_route = Route.new(travel_mode: 'cab')
    cab_route.duration = uber_res.wait_time + route.duration*traffic_multiplier
    route.travel_mode = 'cab'
    route.wait_time = uber_res.wait_time
    cab_route.calculate_and_set_all_exp(route, forecast)
    cab_route
  end

  def self.divvy(route, forecast)
    divvy_route = Route.new(travel_mode: 'divvy')
    route.travel_mode = 'divvy'
    divvy_route.duration = route.duration #add in divvy find time?
    divvy_route.calculate_and_set_all_exp(route, forecast)
    divvy_route
  end

  def self.traffic_multiplier
    hour = Time.now.hour
    traffic_multiplier = 1
    case hour
    when 6, 16, 19
      traffic_multiplier = 1.1
    when 7, 8, 17, 18
      traffic_multiplier = 1.2
    end
    traffic_multiplier
  end

end
