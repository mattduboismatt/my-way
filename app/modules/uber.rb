module UberParser

  def self.run(route)
    a = route.origin
    b = route.destination
    time_uri =  UberParser.time_build_uri(a)
    price_uri = UberParser.price_build_uri(a,b)
    time_res = Net::HTTP.get(time_uri)
    price_res = Net::HTTP.get(price_uri)
    uber = UberParser.generate_uber(price_res, time_res)
    uber.set_standard_properties(route)
    uber
  end

  def self.price_build_uri(a,b)
    host = 'api.uber.com'
    path = "/v1/estimates/price"
    price_query = {
      server_token:  ENV['UBER_API_KEY'],
      start_latitude: a['lat'],
      start_longitude: a['lng'],
      end_latitude: b['lat'],
      end_longitude: b['lng']
    }
    URI::HTTPS.build(host: host, path: path, query: URI.encode_www_form(price_query))
  end

   def self.time_build_uri(a)
    host = 'api.uber.com'
    path = "/v1/estimates/time"
    time_query= {
      server_token: ENV['UBER_API_KEY'],
      start_latitude: a['lat'],
      start_longitude: a['lng']
    }
    URI::HTTPS.build(host: host, path: path, query: URI.encode_www_form((time_query)))
  end

  def self.generate_uber(price_res,time_res)
    price_data = JSON.parse(price_res)
    time_data = JSON.parse(time_res)
    price_data["prices"].each do |price|
      time_data["times"].each do |time|
        if price['display_name'] == 'uberX' && time['display_name'] == 'uberX'
          uber_data = price.merge(time)
          return Uber.new(uber_data)
        end
      end
    end
  end

end

class Uber
  attr_accessor :duration, :distance, :origin, :destination
  attr_reader :high_estimate, :low_estimate, :type, :surge, :duration, :travel_mode, :wait_time
  def  initialize(uber_data)
    @travel_mode = 'uber'
    @high_estimate = uber_data['high_estimate']
    @low_estimate = uber_data['low_estimate']
    @type = uber_data['display_name']
    @surge = uber_data['surge_multiplier']
    @duration = uber_data['duration'] #overwrite in set_distance_and_duration
    @distance = nil
    @wait_time = uber_data['estimate'] # in seconds!!
    @origin = nil
    @destination = nil
  end

  def set_standard_properties(gr)
    self.reset_distance_and_duration(gr)
    self.set_origin_and_destination(gr)
  end

  def reset_distance_and_duration(gr)
    @distance = gr.distance
    @duration = gr.duration
  end

  def set_origin_and_destination(gr)
    @origin = gr.origin
    @destination = gr.destination
  end

    def self.distance(miles)
    if miles < 6
      (0.688*(miles)**3 - 4.322*(miles)**2 - 6.515*(miles) + 100).to_i
    else
      48
    end
  end

  def self.cost(route)
    (route.high_estimate + route.low_estimate) / 2
  end

  def self.dollars(factors)
    duration = factors["duration"]
    time_constant = factors["time_constant"]
    actual_cost = factors["actual_cost"]
    money_time_factor = factors["money_time_factor"]
    (100 - (duration*time_constant+actual_cost)*money_time_factor).to_i
  end


end


