class TripsController < ApplicationController
  def create
    @trip = Trip.create!(user: current_user)
    @trip.set_origin(params[:origin], current_user)
    @trip.set_destination(params[:destination], current_user)
    @trip.generate_and_score_routes
    render :show
  end
end
