# load_all 'app'

# class Route
#   attr_reader :travel_mode, :distance
#   def initialize(args)
#     @travel_mode = args[:travel_mode]
#     @distance = args[:distance]
#   end
# end

module DistanceAlgorithm

  def self.run(route)
    mode = route.travel_mode
    distance = route.distance ### in meters
    distance_exp = 0
    case mode
    when 'walking'
      distance_exp = 100 - ((distance.to_f/260)**1.75).to_i
    when 'bicycling'
      distance_exp = 100 - ((distance.to_f/435)**1.75).to_i
    else # 'driving', 'cab', 'uber', 'bus', 'subway'
      distance = distance.to_f
      case distance
      when 0..1600 # 0 to 1 mile
        distance_base_exp = 8 + distance*0.00625 # 10 exp per mile, 8-18
      when 1600..2400 # 1 to 1.5 mile
        distance_base_exp = 18 + (distance-1600)*0.0125 # 20 exp per mile, 18-28
      when 2400..4000 # 1.5 to 2.5 mile
        distance_base_exp = 28 + (distance-2400)*0.01875 # 30 exp per mile, 28-58
      when 4000..4800 # 2.5 to 3 mile
        distance_base_exp = 58 + (distance-4000)*0.0125 # 20 exp per mile, 58-68
      when 4800..6400 # 3 to 4 mile
        distance_base_exp = 68 + (distance-4800)*0.00625 # 10 exp per mile, 68-78
      else # anything londer than 4 miles
        distance_base_exp = 78 # constant 78, to be multiplied by factor to differentiate driving vs uber vs transit, etc.
      end
      case mode
      when 'driving'
        distance_exp = (distance_base_exp * 1.2).to_i
      when 'cab'
        distance_exp = (distance_base_exp * 1.1).to_i
      when 'uber'
        distance_exp = (distance_base_exp * 1.05).to_i
      when 'bus', 'subway'
        distance_exp = (distance_base_exp).to_i
      end
    end
    # puts "#{mode} - #{distance} - #{distance_exp}"
    distance_exp > 0 ? distance_exp : 0
  end
end


# distances = (0..24).to_a.map!{|x| x*400}
# routes = []
# distances.each do |d|
#   routes << Route.new(travel_mode: 'walking', distance: d)
# end
# distances.each do |d|
#   routes << Route.new(travel_mode: 'bicycling', distance: d)
# end
# distances.each do |d|
#   routes << Route.new(travel_mode: 'driving', distance: d)
# end
# distances.each do |d|
#   routes << Route.new(travel_mode: 'uber', distance: d)
# end
# distances.each do |d|
#   routes << Route.new(travel_mode: 'cab', distance: d)
# end
# distances.each do |d|
#   routes << Route.new(travel_mode: 'bus', distance: d)
# end
# distances.each do |d|
#   routes << Route.new(travel_mode: 'subway', distance: d)
# end

# routes.each{|r| DistanceAlgorithm.run(r)}
