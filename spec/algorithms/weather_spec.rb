# require 'rails_helper'
# require 'hashie'
# require './app/algorithms/weather.rb'
# require './spec/weather_helper.rb'

# class NewRoute
#   attr_reader :origin, :destination, :travel_mode
#   def initialize(args)
#     @origin = args[:origin]
#     @destination = args[:destination]
#     @travel_mode = args[:travel_mode]
#   end
# end
# $apple = Forecast.new({"lat"=>41.8369, "lng"=>87.6847})
# $apple.forecast = FORECAST


# describe "Weather" do
#   let(:route) {NewRoute.new({origin:{"lat"=>41.8369, "lng"=>87.6847}, destination:{"lat"=>41.8806, "lng"=>87.6742}, travel_mode: "walking"})}
#   let(:forecast) {$apple}
#   it "route.score returns an integer between 1-100" do
#     expect(WeatherAlgorithm.run(route, $apple)).to eq(64)
#   end
#   it "should change deg_to_compass" do
#     expect(forecast.current_wind_bearing_compass).to be_truthy
#   end

#   it "should show precip_probability" do
#     expect(forecast.current_precip_probability).to be_truthy
#   end

#   it "should show humidity" do
#     expect(forecast.current_humidity).to be_truthy
#   end

#   it "should show precip intensity" do
#     expect(forecast.current_precip_intensity).to be_truthy
#   end

#   it "should show precise temperature" do
#     expect(forecast.current_precise_temp).to be_truthy
#   end

#   it "should show precip_probability" do
#     expect(forecast.next_hour_precip_probability).to be_truthy
#   end

#   it "should show humidity" do
#     expect(forecast.next_hour_humidity).to be_truthy
#   end

#   it "should show precip intensity" do
#     expect(forecast.next_hour_precip_intensity).to be_truthy
#   end

#   it "should show precise temperature" do
#     expect(forecast.next_hour_precise_temp).to be_truthy
#   end

#   it "should show apparent temperature" do
#     expect(forecast.next_hour_apparent_temp).to be_truthy
#   end

#   it "should show wind bearing" do
#     expect(forecast.next_hour_wind_bearing).to be_truthy
#   end

#   it "should show wind speed" do
#     expect(forecast.next_hour_wind_speed).to be_truthy
#   end

#   it "should show sunrise" do
#     expect(forecast.sunrise).to be_truthy
#   end

#   it "should show sunset" do
#     expect(forecast.sunset).to be_truthy
#   end

# end

