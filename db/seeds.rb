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

# User.create
# Question.create(content: "apple jacks")
# Question.create(content: "jack apples")
# Answer.create(question_id: 1, content: "yes", weather_modifier: 2.0, dollars_modifier: 1.5, distance_modifier: 1.0, duration_modifier: 0.5)
# Answer.create(question_id: 2, content: "yes", weather_modifier: 2.0, dollars_modifier: 1.5, distance_modifier: 1.0, duration_modifier: 0.5)
# UsersAnswer.create(answer_id: 1, user_id: 1)
# UsersAnswer.create(answer_id: 2, user_id: 1)
