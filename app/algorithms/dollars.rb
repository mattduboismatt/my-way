require './app/modules/parking.rb'

module DollarsAlgorithm
  def self.actual_cost(route)
    mode = route.travel_mode
    distance = route.distance.to_f / 1600
    duration = route.duration
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
        actual_cost = base_cost + mile_cost + time_cost
    end
    actual_cost = actual_cost.round(2)
    actual_cost
  end

  def self.run(actual_cost)
    dollars_exp = (100 - (actual_cost * 5)).to_i
    dollars_exp > 0 ? dollars_exp : 0
  end
end

