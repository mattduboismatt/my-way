class Bus

  def self.distance(miles)
   if miles < 6
        (0.918*(miles)**3 - 5.429*(miles)**2 - 11.186*(miles) + 100).to_i
      else
        43
      end
  end

  def self.cost
    2.00
  end

  def self.dollars(factors)
    duration = factors["duration"]
    time_constant = factors["time_constant"]
    actual_cost = factors["actual_cost"]
    money_time_factor = factors["money_time_factor"]
    (100 - (duration*time_constant+actual_cost)*money_time_factor).to_i
  end

end