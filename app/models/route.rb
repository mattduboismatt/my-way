class Route
  attr_reader :travel_mode
  attr_accessor :distance_exp, :duration_exp, :dollars_exp, :weather_exp, :safety_exp, :comfort_exp, :total_exp
  def initialize(args)
    @travel_mode = args[:travel_mode]
    @distance_exp = 0
    @duration_exp = 0
    @dollars_exp = 0
    @weather_exp = 0
    @safety_exp = 0
    @comfort_exp = 0
    @total_exp = 0
  end

  def set_total_exp
    @total_exp = @distance_exp + @duration_exp + @dollars_exp + @weather_exp + @safety_exp + @comfort_exp
  end
end
