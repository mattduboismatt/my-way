require 'rails_helper'
require './app/algorithms/distance.rb'
DISTANCES = (0..20).to_a.map!{|x| x*400}
MODES = %w(driving uber cab walking bicycling divvy bus subway)
class DisRoute
  attr_reader :travel_mode, :distance
  def initialize(mode, dist = DISTANCES.sample)
    @travel_mode = mode
    @distance = dist
  end
end


describe 'Distance Algorithm' do
  MODES.each do |mode|
    describe "checks #{mode} for limits" do
      let(:route) {DisRoute.new(mode)}

      it 'returns an integer' do
        expect(DistanceAlgorithm.run(route)).to be_an(Integer)
      end
      it 'returns exp less than 100' do
        expect(DistanceAlgorithm.run(route)).to be <= 100
      end
      it 'returns exp greater than 0' do
        expect(DistanceAlgorithm.run(route)).to be >= 0
      end
    end
  end

  describe 'favors certain modes over others at every distance' do
    DISTANCES.each do |dist|
      let(:divvy) {DisRoute.new('divvy', dist)}
      let(:bike) {DisRoute.new('bicycling', dist)}
      let(:walk) {DisRoute.new('walking', dist)}
      let(:drive) {DisRoute.new('driving', dist)}
      let(:uber) {DisRoute.new('uber', dist)}
      let(:cab) {DisRoute.new('cab', dist)}
      let(:bus) {DisRoute.new('bus', dist)}
      let(:subway) {DisRoute.new('subway', dist)}
      it 'divvy == bike' do
        expect(DistanceAlgorithm.run(divvy)).to eq(DistanceAlgorithm.run(bike))
      end
      it 'bike > walk' do
        expect(DistanceAlgorithm.run(bike)).to be >= DistanceAlgorithm.run(walk)
      end
      it 'divvy > walk' do
        expect(DistanceAlgorithm.run(divvy)).to be >= DistanceAlgorithm.run(walk)
      end
      it 'drive > cab' do
        expect(DistanceAlgorithm.run(drive)).to be >= DistanceAlgorithm.run(cab)
      end
      it 'cab > uber' do
        expect(DistanceAlgorithm.run(cab)).to be >= DistanceAlgorithm.run(uber)
      end
      it 'uber > subway' do
        expect(DistanceAlgorithm.run(uber)).to be >= DistanceAlgorithm.run(subway)
      end
      it 'subway == bus' do
        expect(DistanceAlgorithm.run(subway)).to be == DistanceAlgorithm.run(bus)
      end
    end
  end

  describe 'favors certain modes over others at 800 meters' do
    let(:dist) {800}
    let(:divvy) {DistanceAlgorithm.run(DisRoute.new('divvy', dist))}
    let(:bike) {DistanceAlgorithm.run(DisRoute.new('bicycling', dist))}
    let(:walk) {DistanceAlgorithm.run(DisRoute.new('walking', dist))}
    let(:drive) {DistanceAlgorithm.run(DisRoute.new('driving', dist))}
    let(:uber) {DistanceAlgorithm.run(DisRoute.new('uber', dist))}
    let(:cab) {DistanceAlgorithm.run(DisRoute.new('cab', dist))}
    let(:bus) {DistanceAlgorithm.run(DisRoute.new('bus', dist))}
    let(:subway) {DistanceAlgorithm.run(DisRoute.new('subway', dist))}
    it 'bike and walk to be greater than vehicular modes' do
      expect(bike).to be >= uber
      expect(walk).to be >= drive
      expect(divvy).to be >= subway
    end
  end
end
