Parkwhiz.api_key = ENV["PARKING_WHIZ_API_KEY"]

class Parking

  attr_accessor :cost
  attr_reader  :lat, :long, :locations

  def initialize(route)
    @lat = route.destination['lat']
    @lng = route.destination['lng']
    # @locations = Array(Parkwhiz.search({ destination: coordinates_to_address}))
    # @cost = 0
  end

  # def coordinates_to_address
  #   address = Geocoder.search("#{@lat}, #{@long}")
  #   address[0].address
  # end

  # def calculate_cost
  #   binding.pry
  #   @locations.each {|location| @cost += location.price }
  #   @cost = @cost/@locations.length
  #   if @cost == 0
  #     @cost = Parking.add_street_parking
  #   end
  #   @cost
  # end

  def street_parking_cost
    # binding.pry
    hours = 2
    if @lat >= 41.91077656 || @lat <= 41.8683927 || @lng <= - 87.6481092
     cost = 2*hours
    elsif @lat >= 41.8737774 && @lng >= -87.6356852 && @lat <= 41.885717
     cost = 6*hours
    else
      cost = 4*hours
    end
    cost
  end


end
