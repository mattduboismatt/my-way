class ApplicationController < ActionController::Base
  require './app/modules/darksky.rb'

  protect_from_forgery with: :exception

  private
  def current_user
    @_current_user ||= session[:user_id]
    User.find_by(id: session[:user_id])
  end
  helper_method :current_user

  def logged_in?
    !!current_user
  end
  helper_method :logged_in?

  def temp
    forecast = Rails.cache.fetch("forecast", expires_in: 5.minutes) do
      Forecast.new({'lat' => 41.8896848, 'lng' => -87.6377502}) #dev bootcamp!!
    end
    forecast.current_apparent_temp.round
  end
  helper_method :temp
end
