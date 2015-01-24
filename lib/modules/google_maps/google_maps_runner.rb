require 'pry'
require 'uri'
require 'net/http'
require_relative './google_maps.rb'

# the google map api requires a request for each travel mode
# eventually we will build this into a module with origin and destination
# it is posisble to white/black list which requests to make.. TBD
# first request sets up the trip and the next 3 add routes to that trip

b = "2756 N. Pine Grove, Chicago, IL"
a = "505 Fair Ave., Elmhurst IL"
init_mode = ["driving"]
modes = ["walking","bicycling","transit"]

req = GoogleMaps.build_uri(a,b,init_mode)
res = Net::HTTP.get(req)
trip = GoogleMaps.build_trip(res)

modes.each do |m|
  req = GoogleMaps.build_uri(a,b,m)
  res = Net::HTTP.get(req)
  GoogleMaps.build_trip(res, trip)
end

i = 1

trip.routes.each do |r|
  p "Route"+i.to_s
  p "Route travel mode: "+r.travel_mode
  r.steps.each do |s|
    puts s.inspect
  end
  p "=================="
  i += 1
end
