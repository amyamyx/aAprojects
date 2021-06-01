class UsersController <ApplicationController
  before_action :ensure_logged_out, except: [:show]
  before_action :ensure_logged_in, only: [:show]

  def new
  end

  def create
    user = User.new(user_params)

    if user.save
      login!(user)
      redirect_to bands_url
    else
      flash.now[:errors] = user.errors.full_messages
      render :new
    end
  end
  
  def show
    @user = User.find(params[:id])
  end

  def activate
    user = User.find_by(activation_token: params[:activation_token])
    
    if user
      flash[:activate_message] = "Your account is activated! Please log in!"
      user.activate!
      # send welcome email
      redirect_to new_session_url
    else
      render json: "Invalid token", status: :not_found
    end
  end
end