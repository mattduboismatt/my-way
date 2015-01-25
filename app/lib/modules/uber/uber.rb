require 'uri'
require "net/http"
require 'pry'
require 'json'



module UberParser
  def self.price_build_uri(a,b)
    host = 'api.uber.com'
    path = "/v1/estimates/price"
    price_query = {
      server_token:  ENV['UBER_API_KEY'],
      start_latitude: a[:lat],
      start_longitude: a[:lng],
      end_latitude: b[:lat],
      end_longitude: b[:lng]
    }
    URI::HTTPS.build(host: host, path: path, query: URI.encode_www_form(price_query))
  end

   def self.time_build_uri(a)
    host = 'api.uber.com'
    path = "/v1/estimates/time"
    time_query= {
      server_token: ENV['UBER_API_KEY'],
      start_latitude: a[:lat],
      start_longitude: a[:lng]
    }
    URI::HTTPS.build(host: host, path: path, query: URI.encode_www_form((time_query)))
  end

  def self.generate_ubers(price_res,time_res)
    price_data = JSON.parse(price_res)
    time_data = JSON.parse(time_res)
    price_data["prices"].each do |price|
      time_data["times"].each do |time|
        if price['display_name'] == time['display_name']
          uber_data = price.merge(time)
          puts Uber.new(uber_data).inspect
        end
      end
    end
  end

end

class Uber
  attr_reader :high_estimate, :low_estimate, :type, :surge, :duration
  def  initialize(uber_data)
   @high_estimate = uber_data['high_estimate']
   @low_estimate = uber_data['low_estimate']
   @type = uber_data['display_name']
   @surge = uber_data['surge_multiplier']
   @duration = uber_data['duration']
   @wait_time = uber_data['estimate'] # in seconds!!
 end
end


