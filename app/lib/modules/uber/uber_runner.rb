require_relative './uber.rb'
a = {lat: 41.9219862, lng: -87.6470420}
b = {lat: 41.9108325, lng: -87.639094}

time_uri =  UberParser.time_build_uri(a)
price_uri = UberParser.price_build_uri(a,b)
time_res = Net::HTTP.get(time_uri)
price_res = Net::HTTP.get(price_uri)
# ubers = UberParser.generate_ubers(price_res, time_res)
