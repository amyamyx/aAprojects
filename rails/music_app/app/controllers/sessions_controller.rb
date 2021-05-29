class SessionsController < ApplicationController
  before_action :ensure_logged_out, except: [:destroy]
  before_action :ensure_logged_in, only: [:destroy]

  def new
  end

  def create
    user = User.find_by_credentials(
      user_params[:email],
      user_params[:password]
    )

    if user
      login!(user)
      redirect_to bands_url
    else
      flash.now[:errors] = ["Wrong credentials!"]
      render :new
    end
  end

  def destroy
    logout!
    redirect_to new_session_url
  end
end