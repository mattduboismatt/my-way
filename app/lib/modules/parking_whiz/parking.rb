require 'parkwhiz'
require 'geocoder'

Parkwhiz.api_key = "--------------"


class Parking

  attr_accessor :cost
  attr_reader  :lat, :long, :locations

  def initialize(route)
    @lat = route.destination['lat']
    @long = route.destination['lng']
    @locations = Array(Parkwhiz.search({ destination: coordinates_to_address}))
    @cost = 0
  end

  def coordinates_to_address
    address = Geocoder.search("#{@lat}, #{@long}")
    address[0].address
  end

  def calculate_cost
    @locations.each {|location| @cost += location.price }
    @cost = @cost/@locations.length
    if @cost == 0
      @cost = Parking.add_street_parking
    end
    @cost
  end

  def self.add_street_parking
    if @lat >= 41.91077656 || @lat <= 41.8683927 ||@lng <= - 87.6481092
     @cost = 4
   elsif @lat >= 41.8737774 && @lng >= -87.6356852 && @lat <= 41.885717
     @cost = 12
    else
      @cost = 8
   end
   @cost
  end


end
