require 'rails_helper'

describe 'Route' do
  let!(:route) { Route.new({travel_mode: "apple"}) }
  it 'route travel mode should be "apple"' do
    expect(route.travel_mode).to eq("apple")
  end

  it 'route distance_exp should be 0' do
    expect(route.distance_exp).to eq(0)
  end

  it 'route duration_exp should be 0' do
    expect(route.duration_exp).to eq(0)
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

  it 'route total_exp should be 0' do
    expect(route.total_exp).to eq(0)
  end

  it 'route actual_cost should be 0.0' do
    expect(route.actual_cost).to eq(0.0)
  end

  it 'set_total_exp should be 0.0' do
    route.set_total_exp
    expect(route.actual_cost).to eq(0.0)
  end

end
