module GoogleMaps

  def self.run(trip)
    init_mode = "driving"
    other_modes = ["walking","bicycling","transit"]
    req = self.build_uri(trip.origin.address,trip.destination.address,init_mode)
    res = Net::HTTP.get(req)
    google_trip = self.build_trip(res)
    other_modes.each do |m|
      req = self.build_uri(trip.origin.address,trip.destination.address,m)
      res = Net::HTTP.get(req)
      self.build_trip(res, google_trip)
    end
    google_trip.routes
  end

  def self.build_uri(a,b,mode)
    if mode == 'transit'
      alt = true
    else
      alt = false
    end
    uri = URI::HTTPS.build({
      host: 'maps.googleapis.com',
      path: '/maps/api/directions/json',
      query: URI.encode_www_form(
        origin: a,
        destination: b,
        mode: mode,
        alternatives: alt,
        region: 'us',
        key: ENV["GOOGLE_MAP_API_KEY"]
      )
    })
  end

  def self.build_trip(json, trip=nil)
    data = JSON.parse(json)
    if trip
      data['routes'].each {|r| trip.add_route(r, trip.origin, trip.destination)}
    else
      trip = GoogleTrip.new(data)
    end
    trip
  end
end

class GoogleThing
  attr_reader :id
  def initialize(*args)
    @id = SecureRandom.uuid
  end
end

class GoogleTrip < GoogleThing
  attr_reader :origin, :destination, :routes

  def initialize(trip_data)
    super
    first_leg = trip_data['routes'][0]['legs'][0]
    @origin = first_leg['start_location']
    @destination = first_leg['end_location']
    @routes = []
    trip_data['routes'].each {|r| add_route(r, @origin, @destination)}
  end

  def add_route(route_data, a, b)
    @routes << GoogleRoute.new(route_data['legs'][0], a, b)
  end
end


class GoogleRoute < GoogleThing
  attr_accessor :travel_mode, :duration, :wait_time
  attr_reader :distance, :steps, :origin, :destination

  def initialize(route_data, a, b)
    super
    @distance = route_data['distance']['value'] # in meters!!!
    @duration = route_data['duration']['value'] # in seconds!!!
    @steps = []
    route_data['steps'].each {|s| add_step(s)}
    @travel_mode = self.set_travel_mode
    @origin = a
    @destination = b
    @wait_time = 0
  end

  def add_step(step_data)
    @steps << GoogleStep.new(step_data)
  end

  def set_travel_mode
    modes = self.steps.map{|s| s.travel_mode }
    if modes.include?('driving')
      'driving'
    elsif modes.include?('bicycling')
      'bicycling'
    elsif modes.include?('transit')
      transit_modes = self.steps.map{|s| s.transit_mode_type }
      if transit_modes.include?('bus')
        'bus'
      elsif transit_modes.include?('subway')
        'subway'
      end
    else
      'walking'
    end
  end
end

class GoogleStep < GoogleThing
  attr_reader :distance, :duration, :travel_mode, :transit_stop_name, :transit_mode_type

  def initialize(step_data)
    super
    @distance = step_data['distance']['value'] # in meters!!!
    @duration = step_data['duration']['value'] # in seconds!!!
    @travel_mode = step_data['travel_mode'].strip.downcase
    @transit_mode_type = self.set_transit_mode_type(step_data['transit_details'])
    @transit_origin_stop_name = self.set_transit_origin_stop_name(step_data['transit_details'])
    @transit_line_name = self.set_transit_line_name(step_data['transit_details'])
    @transit_line_code = self.set_transit_line_code(step_data['transit_details'])
    @transit_headsign = self.set_transit_headsign(step_data['transit_details'])
    @transit_destination_stop_name = self.set_transit_destination_stop_name(step_data['transit_details'])
  end

  def set_transit_mode_type(transit_details)
    if self.travel_mode != 'transit'
      nil
    else
      transit_details['line']['vehicle']['type'].downcase
    end
  end

  def set_transit_origin_stop_name(transit_details)
    if self.travel_mode != 'transit'
      nil
    else
      transit_details['departure_stop']['name'].downcase
    end
  end

  def set_transit_destination_stop_name(transit_details)
    if self.travel_mode != 'transit'
      nil
    else
      transit_details['arrival_stop']['name'].downcase
    end
  end

  def set_transit_line_name(transit_details)
    if self.travel_mode != 'transit'
      nil
    else
      transit_details['line']['name'].downcase
    end
  end

  def set_transit_line_code(transit_details)
    if self.travel_mode != 'transit'
      nil
    else
      if self.transit_mode_type == 'bus'
        transit_details['line']['short_name'].downcase
      elsif self.transit_mode_type == 'subway'
        transit_details['line']['color'].downcase
      end
    end
  end


  def set_transit_headsign(transit_details)
    if self.travel_mode != 'transit'
      nil
    else
      transit_details['headsign'].downcase
    end
  end
end
