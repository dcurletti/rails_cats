class SessionsController < ApplicationController

  before_action :already_logged_in, only: [:new, :create]

  def new
    @user = User.new()
  end

  def create
    user = User.find_by_credentials(params[:user][:user_name], params[:user][:password])
    @user = User.new(user_name: params[:user][:user_name])
    if user
      login!(user)
      redirect_to cats_url
    else

      render :new
    end
  end

  def destroy
    log_out!
    redirect_to :root
  end

end
