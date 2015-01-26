require './app/lib/modules/parking_whiz/parking.rb'

# class Route
#   attr_reader :travel_mode, :distance, :origin, :destination, :duration, :high_estimate, :low_estimate
#   def initialize(args)
#     @travel_mode = args[:travel_mode]
#     @distance = args[:distance]
#     @duration = args[:duration]
#     @origin = args[:origin]
#     @destination = args[:destination]
#     @high_estimate = args[:high_estimate]
#     @low_estimate = args[:low_estimate]
#   end
# end

module DollarsAlgorithm

  def self.run(route)
    mode = route.travel_mode
    distance = route.distance.to_f / 1600
    duration = route.duration
    actual_cost = 0.to_f

    case mode
      when 'driving'
        irs = distance * 0.56
        park = Parking.new(route)
        park_cost = park.calculate_cost
        puts "parking cost #{park_cost}"
        actual_cost = park_cost + irs
      when 'subway'
        actual_cost = 2.25
      when 'bus'
        actual_cost = 2.00
      when 'uber'
        actual_cost = (route.high_estimate + route.low_estimate) / 2
      when 'divvy'
        actual_cost = 7.00
      when 'cab'
        base_fare = 3.25
        mile_exp = distance * 1.80
        time_exp = (duration/36) * 0.2
        actual_cost = base_fare + mile_exp + time_exp
    end
    actual_cost = actual_cost.round(2)
    dollars_exp = (100 - (actual_cost * 5)).to_i
    # puts "#{route.travel_mode} - $#{actual_cost} - #{dollars_exp} exp"
    dollars_exp > 0 ? dollars_exp : 0
  end
end

# a = {'lat' => 41.783587, 'lng' => -87.77558}
# b = {'lat' => 41.908803, 'lng' =>  -87.679598}
# distance = 13600
# duration = 1800
# high = 27
# low = 23
# routes = []
# modes = %w(walking bicycling driving subway bus uber divvy cab)
# modes.each do |m|
#   routes << Route.new(origin: a, destination: b, distance: distance, duration: duration, travel_mode: m, low_estimate: low, high_estimate: high)
# end
# routes.each{ |r| DollarsAlgorithm.run(r) }

