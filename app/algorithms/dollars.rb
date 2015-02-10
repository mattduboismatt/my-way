module DollarsAlgorithm
  def self.actual_cost(route)
    mode = route.travel_mode
    distance = route.distance.to_f / 1600
    duration = route.duration.to_f
    actual_cost = 0.to_f

    case mode
    when 'driving'
      actual_cost = Drive.cost(route)
    when 'subway'
      actual_cost = 2.25
    when 'bus'
      actual_cost = 2.00
    when 'uber'
      actual_cost = Uber.cost(route)
    when 'divvy'
      actual_cost = Divvy.cost
    when 'cab'
      base_cost = 3.25
      mile_cost = distance * 1.80
      time_cost = (duration/36) * 0.2
      actual_cost = (base_cost + mile_cost + time_cost)*1.15
    end
    actual_cost = actual_cost.round(2)
    actual_cost
  end

  def self.run(route, actual_cost)
    mode = route.travel_mode
    dollars_exp = 100
    factors = {"duration" => route.duration.to_f/60,
    "time_constant" => 15/60.0,
    "money_time_factor" => 4.5,
    "actual_cost" => actual_cost}
    case mode
    # when 'walking'
    #   dollars_exp = (100 - (duration*time_constant+actual_cost)*money_time_factor).to_i
    when 'bicycling'
      dollars_exp = Bike.dollars(factors)
    when 'driving'
      dollars_exp = Drive.dollars(factors)
    # when 'subway'
    #   dollars_exp = (100 - (duration*time_constant+actual_cost)*money_time_factor).to_i
    # when 'bus'
    #   dollars_exp = (100 - (duration*time_constant+actual_cost)*money_time_factor).to_i
    when 'uber'
      factors["duration"] = factors["duration"] + route.wait_time/60.0
      dollars_exp = Uber.dollars(factors)
    when 'divvy'
      dollars_exp = Divvy.dollars(factors)
    # when 'cab'
    #   duration = duration + route.wait_time/60.0
    #   dollars_exp = (100 - (duration*time_constant+actual_cost)*money_time_factor).to_i
    end
    dollars_exp > 0 ? dollars_exp : 0
  end

end

