module DistanceAlgorithm

  def self.run(route)
    mode = route.travel_mode
    distance = route.distance.to_f/1609.34 ### in meters
    distance_exp = 0
    case mode
    when 'walking'
      distance_exp = Walk.distance(distance)
    when 'bicycling'
      distance_exp = Bike.distance(distance)
    when 'divvy'
      distance_exp = Divvy.distance(distance)
    when 'driving'
      distance_exp = Drive.distance(distance)
    when 'uber'
      distance_exp = Uber.distance(distance)
    when 'cab'
      if distance < 6
        distance_exp = ( 0.688*(distance)**3 - 4.322*(distance)**2 - 6.515*(distance) + 100).to_i
      else
        distance_exp = 48
      end
    when 'subway'
      if distance < 6
        distance_exp = (0.95*(distance)**3 - 5.736*(distance)**2 - 9.385*(distance) + 100).to_i
      else
        distance_exp = 45
      end
    when 'bus'
      if distance < 6
        distance_exp = (0.918*(distance)**3 - 5.429*(distance)**2 - 11.186*(distance) + 100).to_i
      else
        distance_exp = 43
      end
    end
    distance_exp > 0 ? distance_exp : 0
  end
end
