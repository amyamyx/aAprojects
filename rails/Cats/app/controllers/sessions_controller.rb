class SessionsController < ApplicationController
  before_action :redirect_when_signed_in, except: [:destroy]

  def new
    @user = User.new
  end
  
  def create
    @user = User.find_by_credentials(
      user_params[:username], 
      user_params[:password]
    )
    
    if @user
      login!(@user)
      redirect_to cats_url
    else
      redirect_to new_session_url
    end
  end
  
  def destroy
    @current_user.reset_session_token! if @current_user
    session[:session_token] = nil
    redirect_to new_session_url
  end

  private
  
  def user_params
    params.require(:user).permit(:username, :password)
  end
end