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
      when 'driving'
        distance_exp = 100 - ((distance.to_f/1600)*5).to_i
      when 'bicycling'
        distance_exp = 100 - ((distance.to_f/425)**1.5).to_i
      when 'transit'
        distance_exp = 100 - ((distance.to_f/1600)*10).to_i
      when 'uber'
        distance_exp = 100 - ((distance.to_f/1600)*7).to_i
      else
    end
    puts "#{distance} - #{distance_exp}"
    # distance_exp > 0 ? distance_exp : 0
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
#   routes << Route.new(travel_mode: 'transit', distance: d)
# end
# distances.each do |d|
#   routes << Route.new(travel_mode: 'uber', distance: d)
# end
# routes.each{|r| DistanceAlgorithm.run(r)}
