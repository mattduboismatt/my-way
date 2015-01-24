

class DistanceAlgorithm

  def self.run(route)
    mode = route.travel_mode
    distance = route.distance ### in meters
    distance_exp = 0
    case mode
      when 'walking'
        distance_exp = 100 - distance^0.5
      when 'driving'
      when 'bicycling'
      when 'transit'
      when 'uber'
      else
    end
    puts distance
    puts distance_exp
  end
end


# travel_mode = 'walking'
# route = Route.new(travel_mode: transit_mode, distance: rand(0..2000))
# DistanceAlgorithm.run(route)
