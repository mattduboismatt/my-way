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
end
