module DistanceAlgorithm

  def self.run(route)
    mode = route.travel_mode
    distance = route.distance.to_f ### in meters
    distance_exp = 0
    case mode
    when 'walking'
      distance_exp = 100 - ((distance.to_f/260)**1.75).to_i
    when 'bicycling', 'divvy'
      distance_exp = 100 - ((distance.to_f/435)**1.75).to_i
    when 'driving'
      distance_exp = (0.813*(distance/1600)**3 - 5.723*(distance/1600)**2 - 1.547*(distance/1600) + 100).to_i
    when 'cab', 'uber'
      distance_exp = ( 0.688*(distance/1600)**3 - 4.322*(distance/1600)**2 - 6.515*(distance/1600) + 100).to_i
    when 'bus', 'subway'
      distance_exp = (distance_exp).to_i
    end
    distance_exp > 0 ? distance_exp : 0
  end
end
