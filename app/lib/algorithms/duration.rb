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
      duration_exp = ((-1.0/30)* (duration) + 100).to_i
    when 'driving'
      duration_exp = ((100.0/3600**2)*(duration)**2).to_i
    when 'bicycling'
      duration_exp = ((-1.0/45)* (duration) + 100).to_i
    when 'bus'
      duration_exp = ((-0.000000005509)*(duration)**3 + (0.00003556)*(duration)**2 - (0.072)*(duration) + 100).to_i
    when 'train'
      duration_exp = ((-1.0/55)* (duration) + 100).to_i
    when 'uber'
      duration_exp = ((100.0/3600**2)*(duration)**2).to_i
    when 'taxi'
      duration_exp = ((100.0/3600**2)*(duration)**2).to_i
    end
    # puts "#{duration} - #{duration_exp}"
    duration_exp > 0 ? duration_exp : 0
  end
end


# durations = (0..75).to_a.map!{|x| x*60}
# routes = []
# durations.each do |d|
#   routes << Route.new(travel_mode: 'walking', duration: d)
# end
# durations.each do |d|
#   routes << Route.new(travel_mode: 'bicycling', duration: d)
# end
# durations.each do |d|
#   routes << Route.new(travel_mode: 'driving', duration: d)
# end
# durations.each do |d|
#   routes << Route.new(travel_mode: 'bus', duration: d)
# end
# durations.each do |d|
#   routes << Route.new(travel_mode: 'train', duration: d)
# end
# durations.each do |d|
#   routes << Route.new(travel_mode: 'uber', duration: d)
# end
# routes.each{|r| DurationAlgorithm.run(r)}
