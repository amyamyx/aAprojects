class CatsController < ApplicationController
  before_action :redirect_if_not_owner, only: [:update, :edit]

  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find_by(id: params[:id])
    @requests = @cat.cat_rental_requests.order(:start_date)
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = Cat.new(cat_params)
    @cat.user_id = current_user.id

    if @cat.save
      redirect_to cat_url(@cat)
    else
      redirect_to new_cat_url
    end
  end

  def edit
    @cat = Cat.find_by(id: params[:id])
    render :edit
  end

  def update
    @cat = Cat.find_by(id: params[:id])
    if @cat.update_attributes(cat_params)
      redirect_to cat_url(@cat)
    else
      redirect_to edit_cat_url(@cat)
    end
  end

  private

  def cat_params
    params.require(:cat).permit(:name, :sex, :birth_date, :description, :color)
  end
  
  def redirect_if_not_owner
    @cat = Cat.find_by(id: params[:id])
    redirect_to cat_url(@cat) if @cat.user_id != current_user.id
  end
end