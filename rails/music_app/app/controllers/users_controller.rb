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
end