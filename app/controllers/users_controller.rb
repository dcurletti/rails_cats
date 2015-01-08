class UsersController < ApplicationController
  before_action :already_logged_in, only: [:new, :create] 

  def create
    @user = User.new(user_params)
    if @user.save
      login!(@user)
      redirect_to user_url(@user)
    else
      flash[:error] = @user.errors.full_messages
      render :new
    end

  end

  def new
    @user = User.new()
  end

  def index
    @users = User.all
  end

  def show
    # fail
    @user = User.find_by(id: params[:id])
  end

  private
  def user_params
    params.require(:user).permit(:user_name, :password)
  end
end
