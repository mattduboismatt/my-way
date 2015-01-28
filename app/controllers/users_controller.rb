class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = 'Registered successfully'
      redirect_to question_path(Question.first)
    else
      flash[:notice] = 'Registration failed'
      render :new
    end
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Profile updated"
      redirect_to root_path
    else
      flash[:notice] = "Profile not updated"
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:notice] = "Account successfully destroyed"
    redirect_to root_path
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
