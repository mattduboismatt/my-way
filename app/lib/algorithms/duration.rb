module DurationAlgorithm

  def self.run(route)
    mode = route.travel_mode
    duration = route.duration ### in seconds
    duration_exp = 0
    case mode
    when 'walking'
      duration_exp = ((-1.0/30)* (duration) + 100).to_i
    when 'driving'
      duration_exp = (4.224E-15*duration**5 - 4.169E-11*duration**4 + 1.398E-7*duration**3 - 1.771E-4*duration**2 + 0.084*duration+ 18.634).to_i
      duration_exp < 100 ? duration_exp : 100
    when 'bicycling'
      duration_exp = ((-1.0/45)* (duration) + 100).to_i
    when 'bus'
      duration_exp = ((-0.000000005509)*(duration)**3 + (0.00003556)*(duration)**2 - (0.072)*(duration) + 100).to_i
    when 'subway'
      duration_exp = ((-1.0/55)* (duration) + 100).to_i
    when 'uber'
      duration_exp = (4.224E-15*duration**5 - 4.169E-11*duration**4 + 1.398E-7*duration**3 - 1.771E-4*duration**2 + 0.084*duration+ 18.634).to_i - ((route.wait_time)/30).to_i
      duration_exp < 100 ? duration_exp : 100
    when 'cab'
      duration_exp = (4.224E-15*duration**5 - 4.169E-11*duration**4 + 1.398E-7*duration**3 - 1.771E-4*duration**2 + 0.084*duration+ 18.634).to_i -((route.wait_time)/30).to_i
      duration_exp < 100 ? duration_exp : 100
    end
    duration_exp > 0 ? duration_exp : 0
  end
end