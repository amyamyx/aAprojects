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

  private

  def request_params
    params.require(:request).permit(:cat_id, :start_date, :end_date, :status)
  end
end