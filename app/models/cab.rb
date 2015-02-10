class Cab

  def self.distance(miles)
      if miles < 6
        ( 0.688*(miles)**3 - 4.322*(miles)**2 - 6.515*(miles) + 100).to_i
      else
        48
      end
  end

  def self.cost(route)
      base_cost = 3.25
      mile_cost = distance * 1.80
      time_cost = (duration/36) * 0.2
      (base_cost + mile_cost + time_cost)*1.15
  end

  def self.dollars(factors)
    duration = factors["duration"]
    time_constant = factors["time_constant"]
    actual_cost = factors["actual_cost"]
    money_time_factor = factors["money_time_factor"]
    (100 - (duration*time_constant+actual_cost)*money_time_factor).to_i
  end

end
