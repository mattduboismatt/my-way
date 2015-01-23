class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Welcome back"
      redirect_to root_path
    else
      flash[:notice] = "Invalid email or password"
      render :new
    end
  end

  def destroy
    logout
    flash[:notice] = "Come back soon"
    redirect_to root_path
  end

  private
  def logout
    @_current_user = nil
    session[:user_id] = nil
  end
end
