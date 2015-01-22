API_KEY = "AIzaSyClV5bTRh3SLEKa36alo9DW3PMX8mrTSdk"
# request = https://maps.googleapis.com/maps/api/directions/json? + parameters

module GoogleMapsRequest
  def self.set_origin(origin_str)
    "origin="+origin_str
  end

  def self.set_destination(destination_str)
    "&destination="+destination_str
  end

  def self.set_key
    "&key="+API_KEY
  end

  def self.standard_params
    "&alternatives=true&region=us"
  end

  def self.set_mode(mode)
    "&mode="+mode
  end

  def self.full_request(a,b,mode)
    "https://maps.googleapis.com/maps/api/directions/json?"+self.set_origin(a)+self.set_destination(b)+self.set_mode(mode)+self.standard_params+self.set_key
  end
end

a = "2756 N. Pine Grove Ave., Chicago, IL"
b = "351 W. Hubbard, Chicago, IL"

puts GoogleMapsRequest.full_request(a,b,"transit")
