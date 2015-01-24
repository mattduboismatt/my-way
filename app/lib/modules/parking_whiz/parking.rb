require 'parkwhiz'
require 'geocoder'

Parkwhiz.api_key = --------------

class Parking

  attr_accessor :cost
  attr_reader  :lat, :long, :locations

  def initialize(lat, long)
    @lat = lat.to_f
    @long = long.to_f
    @locations = Array(Parkwhiz.search({ destination: coordinates_to_address}))
    @cost = 0
  end

  def coordinates_to_address
    address = Geocoder.search("#{@lat}, #{@long}")
    address[0].address
  end

  def calculate_cost
    @locations.each {|location| @cost += location.price }
    @cost= @cost/@locations.length
  end

end
