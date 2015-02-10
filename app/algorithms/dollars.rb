module DollarsAlgorithm
  def self.actual_cost(route)
    mode = route.travel_mode
    actual_cost = 0.to_f

    case mode
    when 'driving'
      actual_cost = Drive.cost(route)
    when 'subway'
      actual_cost = Train.cost
    when 'bus'
      actual_cost = Bus.cost
    when 'uber'
      actual_cost = Uber.cost(route)
    when 'divvy'
      actual_cost = Divvy.cost
    when 'cab'
      actual_cost = Cab.cost(route)
    end
    actual_cost = actual_cost.round(2)
  end

  def self.run(route, actual_cost)
    mode = route.travel_mode
    dollars_exp = 100
    factors = {"duration" => route.duration.to_f/60,
    "time_constant" => 15/60.0,
    "money_time_factor" => 4.5,
    "actual_cost" => actual_cost}
    case mode
    when 'walking'
      dollars_exp = Walk.dollars(factors)
    when 'bicycling'
      dollars_exp = Bike.dollars(factors)
    when 'driving'
      dollars_exp = Drive.dollars(factors)
    when 'subway'
      dollars_exp = Train.dollars(factors)
    when 'bus'
      dollars_exp = Bus.dollars(factors)
    when 'uber'
      factors["duration"] = factors["duration"] + route.wait_time/60.0
      dollars_exp = Uber.dollars(factors)
    when 'divvy'
      dollars_exp = Divvy.dollars(factors)
    when 'cab'
      factors["duration"] = factors["duration"] + route.wait_time/60.0
      dollars_exp = Cab.dollars(factors)
    end
    dollars_exp > 0 ? dollars_exp : 0
  end

end

