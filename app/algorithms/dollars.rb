module DollarsAlgorithm
  def self.actual_cost(route)
    mode = route.travel_mode
    distance = route.distance.to_f / 1600
    duration = route.duration.to_f
    actual_cost = 0.to_f


    case mode
    when 'driving'
      irs_cost = distance * 0.56
      parking = Parking.new(route)
      park_cost = parking.street_parking_cost
      puts "parking cost #{park_cost}"
      actual_cost = park_cost + irs_cost
    when 'subway'
      actual_cost = 2.25
    when 'bus'
      actual_cost = 2.00
    when 'uber'
      actual_cost = (route.high_estimate + route.low_estimate) / 2
    when 'divvy'
      actual_cost = 7.00
    when 'cab'
      base_cost = 3.25
      mile_cost = distance * 1.80
      time_cost = (duration/36) * 0.2
      actual_cost = (base_cost + mile_cost + time_cost)*1.15
    end
    actual_cost = actual_cost.round(2)
    actual_cost
  end

  def self.time_of_day
    hour = Time.now.hour
    traffic_factor = 1
    case hour
    when 6..9, 16..19
      traffic_factor = 1.1
    end
  end



  def self.run(route, actual_cost)
    mode = route.travel_mode
    duration = route.duration.to_f
    dollars_exp = 100
    case mode
    when 'driving'
      dollars_exp = (100 - ((actual_cost/(duration*time_of_day)) * 5)).to_i
    when 'subway'
      dollars_exp = (100 - ((actual_cost/duration) * 5)).to_i
    when 'bus'
      dollars_exp = (100 - ((actual_cost/(duration*time_of_day)) * 5)).to_i
    when 'uber'
      duration = duration + route.wait_time
      dollars_exp = (100 - ((actual_cost/(duration*time_of_day)) * 5)).to_i
    when 'divvy'
      duration = duration + 120
      dollars_exp = (100 - ((actual_cost/duration) * 5)).to_i
    when 'cab'
      duration = duration + route.wait_time
      dollars_exp = (100 - ((actual_cost/(duration*time_of_day)) * 5)).to_i
    end
    dollars_exp > 0 ? dollars_exp : 0
  end
end

