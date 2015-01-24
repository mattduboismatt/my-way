class TripsController < ApplicationController
  def create
    @trip = Trip.new(user: current_user)
    @trip.set_origin(params[:origin], current_user)
    @trip.set_destination(params[:destination], current_user)
    render :show
  end
end
