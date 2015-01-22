require 'pry'
require 'uri'
require 'net/http'
require_relative './google_maps.rb'

# the google map api requires a request for each travel mode
# eventually we will build this into a module with origin and destination
# it is posisble to white/black list which requests to make.. TBD
# first request sets up the trip and the next 3 add routes to that trip

a = "2756 N. Pine Grove, Chicago, IL"
b = "409 W. North Ave Chicago IL"
init_mode = "driving"
other_modes = ["walking","bicycling","transit"]

req = GoogleMaps.build_uri(a,b,init_mode)
res = Net::HTTP.get(req)
trip = GoogleMaps.generate_trip(res)

other_modes.each do |m|
  req = GoogleMaps.build_uri(a,b,m)
  res = Net::HTTP.get(req)
  GoogleMaps.generate_trip(res, trip)
end

# i = 1

# trip.routes.each do |r|
#   p "Route"+i.to_s
#   p "Route travel mode: "+r.travel_mode
#   r.steps.each do |s|
#     p s.travel_mode
#   end
#   p "=================="
#   i += 1
# end
