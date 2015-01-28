class TripsController < ApplicationController
  def create
    wl = params['user']['whitelist']
    if current_user
      current_user.update_multipliers
      current_user.update_whitelist(wl)
    end
    @trip = Trip.create(user: current_user)
    @trip.set_origin(params[:origin], current_user)
    @trip.set_destination(params[:destination], current_user)
    @routes = @trip.generate_and_score_routes(current_user, wl)
    render :show
  end
end
