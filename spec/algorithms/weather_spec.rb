require 'rails_helper'
require 'hashie'
require './app/algorithms/weather.rb'
require './spec/weather_helper.rb'

class Route
  attr_reader :origin, :destination, :travel_mode
  def initialize(args)
    @origin = args[:origin]
    @destination = args[:destination]
    @travel_mode = args[:travel_mode]
  end
end
$apple = Forecast.new({"lat"=>41.8369, "lng"=>87.6847})
$apple.forecast = FORECAST


describe "Weather" do
  let(:route) {Route.new({origin:{"lat"=>41.8369, "lng"=>87.6847}, destination:{"lat"=>41.8806, "lng"=>87.6742}, travel_mode: "walking"})}
  let(:forecast) {$apple}
  let (:weather) { Weather.new(route, forecast) }
  it "route.score returns an integer between 1-100" do
    expect(weather.score).to eq(64)
  end

end

