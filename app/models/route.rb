class Route
  attr_reader :travel_mode
  attr_accessor :distance_exp, :duration_exp, :dollars_exp, :weather_exp, :safety_exp, :comfort_exp, :total_exp, :actual_cost
  def initialize(args)
    @travel_mode = args[:travel_mode]
    @distance_exp = 0
    @duration_exp = 0
    @dollars_exp = 0
    @weather_exp = 0
    @safety_exp = 0
    @comfort_exp = 0
    @total_exp = 0
    @actual_cost = 0.to_f
  end

  def calculate_and_set_all_exp(route_data, forecast)
    @distance_exp = DistanceAlgorithm.run(route_data)
    @duration_exp = DurationAlgorithm.run(route_data)
    @actual_cost = DollarsAlgorithm.actual_cost(route_data)
    @dollars_exp = DollarsAlgorithm.run(route_data, @actual_cost)
    @weather_exp = WeatherAlgorithm.run(route_data, forecast)
    @safety_exp = SafetyAlgorithm.run(route_data.travel_mode)
    self.set_total_exp
  end

  def set_total_exp
    @total_exp = @distance_exp + @duration_exp + @dollars_exp + @weather_exp + @safety_exp + @comfort_exp
  end

  def self.google_driving(route, forecast)
    uber_res = UberParser.run(route)
    [regular(route, forecast), uber(uber_res, forecast), cab(route, uber_res, forecast)]
  end

  def self.google_bicycling(route, forecast)
    [regular(route, forecast), divvy(route, forecast)]
  end

  def self.google_transit_and_walking(route, forecast)
    regular(route, forecast)
  end

  def self.regular(route, forecast)
    reg_route = Route.new(travel_mode: route.travel_mode)
    reg_route.calculate_and_set_all_exp(route, forecast)
    reg_route
  end

  def self.uber(uber_res, forecast)
    uber_route = Route.new(travel_mode: 'uber')
    uber_route.calculate_and_set_all_exp(uber_res, forecast)
    uber_route
  end

  def self.cab(route, uber_res, forecast)
    cab_route = Route.new(travel_mode: 'cab')
    route.travel_mode = 'cab'
    route.wait_time = (uber_res.wait_time)*2
    cab_route.calculate_and_set_all_exp(route, forecast)
    cab_route
  end

  def self.divvy(route, forecast)
    divvy_route = Route.new(travel_mode: 'divvy')
    route.travel_mode = 'divvy'
    divvy_route.calculate_and_set_all_exp(route, forecast)
    divvy_route
  end

end
