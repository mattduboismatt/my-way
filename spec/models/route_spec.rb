require 'rails_helper'

describe 'Route' do
  let!(:route) { Route.new({travel_mode: "apple"}) }
  it 'route travel mode should be "apple"' do
    expect(route.travel_mode).to eq("apple")
  end

  it 'route distance_exp should be 0' do
    expect(route.distance_exp).to eq(0)
  end

  it 'route dollars_exp should be 0' do
    expect(route.dollars_exp).to eq(0)
  end

  it 'route weather_exp should be 0' do
    expect(route.weather_exp).to eq(0)
  end

  it 'route safety_exp should be 0' do
    expect(route.safety_exp).to eq(0)
  end

  it 'route comfort_exp should be 0' do
    expect(route.comfort_exp).to eq(0)
  end

  it 'route weighted_exp should be 0' do
    expect(route.weighted_exp).to eq(0)
  end

  it 'route actual_cost should be 0.0' do
    expect(route.actual_cost).to eq(0.0)
  end

  it 'route duration should be 0.0' do
    expect(route.duration).to eq(0.0)
  end

  it 'set_weighted_exp should be 0.0' do
    route.set_weighted_exp
    expect(route.actual_cost).to eq(0.0)
  end

end
