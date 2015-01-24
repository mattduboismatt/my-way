require 'uri'
require "net/http"
require 'json'

module DivvyParser

  def self.build_uri
    host = 'www.divvybikes.com'
    path = '/stations/json'
    URI::HTTPS.build(host: host, path: path)
  end

  def self.update_divvy(divvy_res)
    divvy_data = JSON.parse(divvy_res)
  end



end


