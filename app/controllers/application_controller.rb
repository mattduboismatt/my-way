class ApplicationController < ActionController::Base

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
end
