require 'rails_helper'
RSpec.describe Location, :type => :model do
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

  describe 'Location address format' do
    describe "with chicago in address"
    let (:address) {"1060 West Addison Street, Chicago, IL"}
    it 'removes any non word character from address after initialize' do
      location = Location.new(address: address)
      expect(location.address).to eq("1060 west addison street  chicago  il")
    end
    it 'downcases address' do
      location = Location.new(address: address)
      expect(location.address).to eq("1060 west addison street  chicago  il")
    end
  end
  describe "with out chicago in address"
  let (:address) {"1901 West Madison Street"} do
    it 'downcases address' do
      location  = Location.new(address: address)
      expect(location.address).to eq("1901 west madison street chicago il")
    end

    it 'downcases address' do
      location  = Location.new(address: address)
      expect(location.address).to eq("1901 west madison street chicago il")
    end
  end
end
