class TripsController < ApplicationController
  def create
    @trip = Trip.new(user: current_user)
    @trip.origin = Location.new(address: params[:origin])
    @trip.destination = Location.new(address: params[:destination])
    render :show
  end
end
