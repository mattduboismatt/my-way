require 'rails_helper'

describe 'Trip' do

  it 'should belong to user' do
    trip = Trip.new
    user = User.new
    user.trips << trip
    expect(trip.user).to be user
  end

  it 'trip.origin should be a location' do
    trip = Trip.new
    user = User.new
    trip.set_origin("apple", user)
    expect(trip.origin).to be_a Location
  end

  it 'trip.destination should be a location' do
    trip = Trip.new
    user = User.new
    trip.set_destination("apple", user)
    expect(trip.destination).to be_a Location
  end

  it 'trip.destination should be a location' do
    trip = Trip.new
    user = User.new
    trip.set_destination("apple", user)
    expect(trip.destination.address).to eq("apple")
  end
end
