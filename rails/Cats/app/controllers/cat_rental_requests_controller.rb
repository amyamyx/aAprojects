class CatRentalRequestsController < ApplicationController
  def new
    @cats = Cat.all
    @request = CatRentalRequest.new
    render :new
  end

  def create
    @request = CatRentalRequest.new(request_params)
    @cat = Cat.find_by(id: request_params[:cat_id])
    
    if @request.save
      redirect_to cat_path(@cat)
    else
      redirect_to new_cat_rental_request_path
    end
  end

  def approve
    request = CatRentalRequest.find(params[:id])
    @cat = Cat.find_by(id: request.cat_id)

    if request.approve!
      redirect_to cat_path(@cat)
    else
      render json: request.errors.full_messages, status: :unprocessible_entity
    end
  end
  
  def deny
    request = CatRentalRequest.find(params[:id])
    @cat = Cat.find_by(id: request.cat_id)

    if request.deny!
      redirect_to cat_path(@cat)
    else
      render json: request.errors.full_messages, status: :unprocessible_entity
    end
  end

  private

  def request_params
    params.require(:request).permit(:cat_id, :start_date, :end_date, :status)
  end
end