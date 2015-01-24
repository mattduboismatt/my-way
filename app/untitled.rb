def self.run(trip)
    modes = ["driving","walking","bicycling","transit"]
    modes.each do |m|
      req = self.build_uri(trip.origin.address,trip.destination.address,m)
      res = Net::HTTP.get(req)
      GoogleMaps.generate_trip(res, trip)
    end
  end
