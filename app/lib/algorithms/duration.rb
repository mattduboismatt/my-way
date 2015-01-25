# load_all 'app'

class Route
  attr_reader :travel_mode, :duration
  def initialize(args)
    @travel_mode = args[:travel_mode]
    @duration = args[:duration]
  end
end

module DurationAlgorithm

  def self.run(route)
    mode = route.travel_mode
    duration = route.duration ### in meters
    duration_exp = 0
    case mode
      when 'walking'
        duration_exp = -(4/3) * (duration)+ 100
      when 'driving'
        duration_exp = 100
      when 'bicycling'
        duration_exp = 100
      when 'transit'
        duration_exp = 100
      when 'uber'
        duration_exp = 100
      else
    end
    puts "#{duration} - #{duration_exp}"
    # duration_exp > 0 ? duration_exp : 0
  end
end


durations = (0..30).to_a.map!{|x| x*2}
routes = []
durations.each do |d|
  routes << Route.new(travel_mode: 'walking', duration: d)
end
durations.each do |d|
  routes << Route.new(travel_mode: 'bicycling', duration: d)
end
durations.each do |d|
  routes << Route.new(travel_mode: 'driving', duration: d)
end
durations.each do |d|
  routes << Route.new(travel_mode: 'transit', duration: d)
end
durations.each do |d|
  routes << Route.new(travel_mode: 'uber', duration: d)
end
routes.each{|r| DurationAlgorithm.run(r)}
