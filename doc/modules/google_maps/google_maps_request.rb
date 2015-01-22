require 'uri'

# API_KEY = ENV["GOOGLE_MAP_API_KEY"]
# request = https://maps.googleapis.com/maps/api/directions/json? + parameters

module GoogleMapsRequest

  def self.build_uri(a,b,mode)
    uri = URI::HTTPS.build({
      host: 'maps.googleapis.com',
      path: '/maps/api/directions/json',
      query: URI.encode_www_form(
        origin: a,
        destination: b,
        mode: mode,
        alternatives: 'true',
        region: 'us',
        key: ENV["GOOGLE_MAP_API_KEY"]
      )
      })
  end
end

a = "2756 N. Pine Grove Ave., Chicago, IL"
b = "409 W. North Ave, Chicago, IL"

puts GoogleMapsRequest.build_uri(a,b,"transit")
