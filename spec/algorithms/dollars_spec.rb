require 'rails_helper'
require './app/algorithms/dollars.rb'
DISTANCES = (0..20).to_a.map!{|x| x*400}
DURATIONS = (0..100).to_a.map!{|x| x*60}
MODES = %w(driving uber cab walking bicycling divvy bus subway)

DolRoute = Struct.new(:travel_mode, :distance, :duration, :destination, :high_estimate, :low_estimate)
Loc = Struct.new(:lat, :lng)

describe 'Dollars Algorithm' do
  let(:dist)      { DISTANCES.sample }
  let(:dur)       { DURATIONS.sample }
  let(:dest)      { Loc.new(rand*100,rand*100) }
  let(:high_est)  { rand(1..100) }
  let(:low_est)   { rand(1..100) }
  let(:divvy)     { DolRoute.new('divvy', dist, dur, dest, high_est, low_est) }
  let(:bicycling) { DolRoute.new('bicycling', dist, dur, dest, high_est, low_est) }
  let(:walking)   { DolRoute.new('walking', dist, dur, dest, high_est, low_est) }
  let(:driving)   { DolRoute.new('driving', dist, dur, dest, high_est, low_est) }
  let(:uber)      { DolRoute.new('uber', dist, dur, dest, high_est, low_est) }
  let(:cab)       { DolRoute.new('cab', dist, dur, dest, high_est, low_est) }
  let(:bus)       { DolRoute.new('bus', dist, dur, dest, high_est, low_est) }
  let(:subway)    { DolRoute.new('subway', dist, dur, dest, high_est, low_est) }

  let(:divvy_cost)  { DollarsAlgorithm.actual_cost(divvy) }
  let(:bike_cost)   { DollarsAlgorithm.actual_cost(bicycling) }
  let(:walk_cost)   { DollarsAlgorithm.actual_cost(walking) }
  let(:drive_cost)  { DollarsAlgorithm.actual_cost(driving) }
  let(:uber_cost)   { DollarsAlgorithm.actual_cost(uber) }
  let(:cab_cost)    { DollarsAlgorithm.actual_cost(cab) }
  let(:bus_cost)    { DollarsAlgorithm.actual_cost(bus) }
  let(:subway_cost) { DollarsAlgorithm.actual_cost(subway) }

  let(:divvy_score)  { DollarsAlgorithm.run(divvy_cost) }
  let(:bike_score)   { DollarsAlgorithm.run(bike_cost) }
  let(:walk_score)   { DollarsAlgorithm.run(walk_cost) }
  let(:drive_score)  { DollarsAlgorithm.run(drive_cost) }
  let(:uber_score)   { DollarsAlgorithm.run(uber_cost) }
  let(:cab_score)    { DollarsAlgorithm.run(cab_cost) }
  let(:bus_score)    { DollarsAlgorithm.run(bus_cost) }
  let(:subway_score) { DollarsAlgorithm.run(subway_cost) }

  describe '#actual dollars' do
    it 'walk is free' do
      expect(walk_cost).to eq 0
    end
    it 'bike is free' do
      expect(bike_cost).to eq 0
    end
    it 'divvy is $7.00' do
      expect(divvy_cost).to eq 7.0
    end
    it 'subway is $2.25' do
      expect(subway_cost).to eq 2.25
    end
    it 'bus is $2.00' do
      expect(bus_cost).to eq 2.00
    end
    it 'drive is $0.55 per mile plus min $4 parking' do
      expect(drive_cost).to be >= ((0.55*dist.to_f/1600)+4)
    end
    it 'cab is $3.25 base plus $1.80 per mile plus $0.20 per 36 seconds' do
      expect(cab_cost) == (3.25+(1.80*dist.to_f/1600)+(0.2*dur.to_f/36)).round(2)
    end
    it 'uber is average of high estimate and low estimate' do
      expect(uber_cost) == (high_est + low_est)/2
    end
  end
end
