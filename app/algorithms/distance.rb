module DistanceAlgorithm

  def self.run(route)
    mode = route.travel_mode
    distance = route.distance.to_f/1609.34 ### in meters
    distance_exp = 0
    case mode
    when 'walking'
      distance_exp = 100 - ((distance.to_f/260*1609.34)**1.75).to_i
    when 'bicycling', 'divvy'
      distance_exp = (-2.445*(distance)**2 - 5.902*(distance)+ 100).to_i
    when 'driving'
      distance_exp = (0.813*(distance)**3 - 5.723*(distance)**2 - 1.547*(distance) + 100).to_i
    when 'cab', 'uber'
      distance_exp = ( 0.688*(distance)**3 - 4.322*(distance)**2 - 6.515*(distance) + 100).to_i
    when 'subway'
      distance_exp = (0.95*(distance)**3 - 5.736*(distance)**2 - 9.385*(distance) + 100).to_i
    when 'bus'
      distance_exp = (0.918*(distance)**3 - 5.429*(distance)**2 - 11.186*(distance) + 100).to_i
    end
    distance_exp > 0 ? distance_exp : 0
  end
end
