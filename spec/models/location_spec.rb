require 'rails_helper'

describe 'Location' do
  it 'location should belong to user' do
    location = Location.new
    user = User.new
    user.locations << location
    expect(location.user).to be user
  end

  it 'trip.origin should be a location' do
    trip = Trip.new
    user = User.new
    trip.set_origin("apple", user)
    expect(trip.origin).to be_a Location
  end
end
