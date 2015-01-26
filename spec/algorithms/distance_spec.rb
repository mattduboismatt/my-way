require 'rails_helper'
require './app/algorithms/distance.rb'
DISTANCES = (0..20).to_a.map!{|x| x*400}
MODES = %w(driving uber cab walking bicycling divvy bus subway)

DisRoute = Struct.new(:travel_mode, :distance)


describe 'Distance Algorithm' do
  let(:divvy)     { DisRoute.new('divvy', dist) }
  let(:bicycling) { DisRoute.new('bicycling', dist)}
  let(:walking)   { DisRoute.new('walking', dist)}
  let(:driving)   { DisRoute.new('driving', dist)}
  let(:uber)      { DisRoute.new('uber', dist)}
  let(:cab)       { DisRoute.new('cab', dist)}
  let(:bus)       { DisRoute.new('bus', dist)}
  let(:subway)    { DisRoute.new('subway', dist)}

  let(:divvy_score)  { DistanceAlgorithm.run(divvy) }
  let(:bike_score)   { DistanceAlgorithm.run(bicycling) }
  let(:walk_score)   { DistanceAlgorithm.run(walking) }
  let(:drive_score)  { DistanceAlgorithm.run(driving) }
  let(:uber_score)   { DistanceAlgorithm.run(uber) }
  let(:cab_score)    { DistanceAlgorithm.run(cab) }
  let(:bus_score)    { DistanceAlgorithm.run(bus) }
  let(:subway_score) { DistanceAlgorithm.run(subway) }

  MODES.each do |mode|
    describe "checks #{mode} for limits" do
      let(:dist) { DISTANCES.sample }
      let(:route_score) { DistanceAlgorithm.run(send(mode)) }
      it 'returns an integer' do
        expect(route_score).to be_an(Integer)
      end
      it 'returns exp less than 100' do
        expect(route_score).to be <= 100
      end
      it 'returns exp greater than 0' do
        expect(route_score).to be >= 0
      end
    end
  end

  context 'at every distance' do
    def score(mode, distance)
      route = DisRoute.new(mode, distance)
      DistanceAlgorithm.run(route)
    end

    it 'divvy == bike' do
      expect(DISTANCES.all? { |dist| score(:divvy, dist) == score(:bicycling, dist) }).to be_truthy
    end

    it 'bike > walk' do
      expect(DISTANCES.all? { |dist| score(:bicycling, dist) >= score(:walking, dist) }).to be_truthy
    end

    it 'divvy > walk' do
      expect(DISTANCES.all? { |dist| score(:divvy, dist) >= score(:walking, dist) }).to be_truthy
    end

    it 'drive > cab' do
      expect(DISTANCES.all? { |dist| score(:driving, dist) >= score(:cab, dist) }).to be_truthy
    end

    it 'cab > uber' do
      expect(DISTANCES.all? { |dist| score(:cab, dist) >= score(:uber, dist) }).to be_truthy
    end

    it 'uber > subway' do
      expect(DISTANCES.all? { |dist| score(:uber, dist) >= score(:subway, dist) }).to be_truthy
    end

    it 'subway == bus' do
      expect(DISTANCES.all? { |dist| score(:subway, dist) == score(:bus, dist) }).to be_truthy
    end
  end

  context 'at 800 meters' do
    let(:dist) {800}

    it 'bike > uber' do
      expect(bike_score).to be >= uber_score
    end
    it 'walk > drive' do
      expect(walk_score).to be >= drive_score
    end
    it 'divvy > subway' do
      expect(divvy_score).to be >= subway_score
    end
  end
  context 'at 1600 meters' do
    let(:dist) {1600}

    it 'bike > uber' do
      expect(bike_score).to be >= uber_score
    end
    it 'walk > drive' do
      expect(walk_score).to be >= drive_score
    end
    it 'divvy > subway' do
      expect(divvy_score).to be >= subway_score
    end
  end
  context 'at 3200 meters' do
    let(:dist) {3200}

    it 'bike > drive' do
      expect(bike_score).to be >= drive_score
    end
    it 'uber > walk' do
      expect(uber_score).to be >= walk_score
    end
    it 'divvy > subway' do
      expect(divvy_score).to be >= subway_score
    end
  end
  context 'at 4800 meters' do
    let(:dist) {4800}

    it 'drive > bike' do
      expect(drive_score).to be >= bike_score
    end
    it 'walk is zero' do
      expect(walk_score).to eq(0)
    end
    it 'subway > divvy' do
      expect(subway_score).to be >= divvy_score
    end
  end
  context 'at 6400 meters' do
    let(:dist) {6400}
    it 'drive > bike' do
      expect(drive_score).to be >= bike_score
    end
    it 'walk is zero' do
      expect(walk_score).to eq(0)
    end
    it 'bike is zero' do
      expect(bike_score).to eq(0)
    end
  end
end

