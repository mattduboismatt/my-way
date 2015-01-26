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

  def calculate_and_set_all_exp(gr, forecast)
    @distance_exp = DistanceAlgorithm.run(gr)
    @duration_exp = DurationAlgorithm.run(gr)
    @actual_cost = DollarsAlgorithm.actual_cost(gr)
    @dollars_exp = DollarsAlgorithm.run(@actual_cost)
    @weather_exp = WeatherAlgorithm.run(gr, forecast)
    self.set_total_exp
  end

  def set_total_exp
    @total_exp = @distance_exp + @duration_exp + @dollars_exp + @weather_exp + @safety_exp + @comfort_exp
  end

  def self.google_driving(route, forecast)
    uber_res = UberParser.run(route)
    [driving(route, forecast), uber(uber_res, forecast), cab(route, uber_res, forecast)]
  end

  def self.google_bicycling(route, forecast)
    [bicycling(route, forecast), divvy(route, forecast)]
  end

  def self.google_transit_and_walking(route, forecast)
    [subway(route, forecast), bus(route, forecast), walking(route, forecast)]
  end

  def self.driving(route, forecast)
    driving_route = Route.new(travel_mode: 'driving')
    driving_route.calculate_and_set_all_exp(route, forecast)
  end

  def self.uber(uber_res, forecast)
    uber_route = Route.new(travel_mode: 'uber')
    uber_route.calculate_and_set_all_exp(uber_res, forecast)
  end

  def self.cab(route, uber_res, forecast)
    cab_route = Route.new(travel_mode: 'cab')
    cab_route.wait_time = (uber_res.wait_time)*2
    route.travel_mode = 'cab'
    uber.calculate_and_set_all_exp(route, forecast)
  end

  def self.bicycling(route, forecast)
    bicycling_route = Route.new(travel_mode: 'bicycling')
    bicycling_route.calculate_and_set_all_exp(route, forecast)
  end

  def self.divvy(route, forecast)
    divvy_route = Route.new(travel_mode: 'divvy')
    route.travel_mode = 'divvy'
    divvy_route.calculate_and_set_all_exp(route, forecast)
  end

  def self.subway(route, forecast)
    subway_route = Route.new(travel_mode: 'subway')
    subway_route.calculate_and_set_all_exp(route, forecast)
  end

  def self.bus(route, forecast)
    bus_route = Route.new(travel_mode: 'bus')
    bus_route.calculate_and_set_all_exp(route, forecast)
  end

  def self.walking(route, forecast)
    walking_route = Route.new(travel_mode: 'walking')
    walking_route.calculate_and_set_all_exp(route, forecast)
  end

end
