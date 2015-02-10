class Walk

  def self.distance(miles)
    if miles <= 2.1
      100 - ((miles.to_f/260*1609.34)**1.75).to_i
    else
      0
    end
  end

  def self.cost(route)
    cost = 0
  end
  def self.dollars(factors)
    duration = factors["duration"]
    time_constant = factors["time_constant"]
    actual_cost = factors["actual_cost"]
    money_time_factor = factors["money_time_factor"]
    (100 - (duration*time_constant+actual_cost)*money_time_factor).to_i
  end

end
