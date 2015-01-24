require 'csv'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

CSV.foreach('./doc/cta_L_stops.csv',{headers:true, :header_converters => :symbol}) {|row| CtaTrainStop.create!(row.to_hash)}

def create_stations
  divvy_data = Divvy.response
  divvy_data['stationBeanList'].each do |station|
    station_data = Divvy.key_map(station)
    Divvy.create!(station_data)
  end
end
create_stations