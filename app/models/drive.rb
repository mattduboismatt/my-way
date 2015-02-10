class Drive

  def self.distance(miles)
    if miles < 6
      (0.813*(miles)**3 - 5.723*(miles)**2 - 1.547*(miles) + 100).to_i
    else
      50
    end
  end

  def self.cost(route)
      irs_cost = route.distance/1609.34 * 0.56
      parking = Parking.new(route)
      park_cost = parking.street_parking_cost
      total = park_cost + irs_cost
  end

  def self.dollars(factors)
    duration = factors["duration"]
    time_constant = factors["time_constant"]
    actual_cost = factors["actual_cost"]
    money_time_factor = factors["money_time_factor"]
    (100 - (duration*time_constant+actual_cost)*money_time_factor).to_i
  end

end
