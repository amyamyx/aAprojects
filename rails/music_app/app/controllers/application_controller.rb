class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :signed_in?

  def current_user
    return nil if session[:session_token]
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def signed_in?
    !!current_user
  end
  
  private

  def login!(user)
    session[:session_token] = user.reset_token!
  end

  def logout!
    current_user.try(:reset_token!)
    session[:session_token] = nil
  end

  def ensure_logged_in
    redirect_to new_session_url unless signed_in?
  end

  def ensure_logged_out
    render json: "you can't perform this action when logged in" if signed_in?
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
