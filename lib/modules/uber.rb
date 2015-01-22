require 'uri'
require "net/http"
require 'pry'
require 'json'

module Uber
  def self.request
    url = 'api.uber.com'
    products = "products"
    time = "/v1/estimates/time"
    price = "/v1/estimates/price"
    server_token =  ''
    start_latitude= "41.9000409"
    start_longitude= "-87.6362244"
    end_latitude = "41.9108325"
    end_longitude = "-87.6390965"
    time_query= {
      server_token: server_token,
      start_longitude: start_longitude,
      start_latitude: start_latitude
    }
    price_query = {
      server_token: server_token,
      start_longitude: start_longitude,
      start_latitude: start_latitude,
      end_longitude: end_longitude,
      end_latitude: end_latitude
    }
    URI::HTTPS.build(host: url, path: price, query: URI.encode_www_form(price_query))
  end

  def self.response(uri)
    Net::HTTP.get(uri)
  end
end

uri =  Uber.request
puts JSON.parse(Uber.response(uri))