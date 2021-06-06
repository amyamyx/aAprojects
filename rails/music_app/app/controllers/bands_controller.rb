class BandsController < ApplicationController
  before_action :ensure_logged_in
  before_action :ensure_admin, except: [:index, :show]
  
  def new
    @band = Band.new
  end

  def create
    @band = Band.new(band_params)
    if @band.save
      redirect_to band_url(@band)
    else
      flash.now[:errors] = @band.errors.full_messages
      render :new
    end
  end
  
  def edit
    @band = Band.find(params[:id])
  end
  
  def update
    @band = Band.find(params[:id])
    
    if @band.update(band_params)
      redirect_to band_url(@band)
    else
      flash.now[:errors] = @band.errors.full_messages
      render :edit
    end
  end

  def index
    @bands = Band.all.order(:id)
  end

  def show
    @band = Band.find_by(id: params[:id])
    @albums = @band.albums
  end

  def destroy
    band = Band.find(params[:id])
    band.destroy
    redirect_to bands_url
  end

  private

  def band_params
    params.require(:band).permit(:name)
  end
end