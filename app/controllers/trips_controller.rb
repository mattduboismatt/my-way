class TripsController < ApplicationController
  def create
    @trip = Trip.new(user: current_user)
    @trip.origin = Location.new(address: params[:origin], user: current_user)
    @trip.destination = Location.new(address: params[:destination], user: current_user)
    render :show
  end
end
