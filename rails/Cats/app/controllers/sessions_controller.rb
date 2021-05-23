class SessionsController < ApplicationController

  def new
    @user = User.new
    render :new
  end
  
  def create
    @user = User.find_by_credentials(
      user_params[:username], 
      user_params[:password]
    )
    
    if @user
      session[:session_token] = @user.reset_session_token!
      redirect_to cats_url
    else
      redirect_to new_session_url
    end
  end
  
  def destroy
    render json: "in the destroy action!"
  end

  private
  
  def user_params
    params.require(:user).permit(:username, :password)
  end
end