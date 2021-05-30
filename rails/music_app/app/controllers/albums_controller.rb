class AlbumsController < ApplicationController
  before_action :ensure_logged_in
  
  def new
    @band = Band.find(params[:band_id])
    @bands = Band.all
    @album = Album.new
  end

  def create
    @album = Album.new(album_params)
    @band = Band.find(@album.band_id)
    @bands = Band.all

    if @album.save
      redirect_to album_url(@album)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :new
    end
  end

  def edit
    @album = Album.find(params[:id])
    @bands = Band.all
    @band = @album.band
  end

  def update
    @album = Album.find(params[:id])

    if @album.update(album_params)
      redirect_to album_url(@album)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :edit
    end
  end 

  def show
    @album = Album.find(params[:id])
    @band = @album.band
    @tracks = @album.tracks.order(:ord)
  end
  
  def destroy
    album = Album.find(params[:id])
    album.destroy
    redirect_to band_url(album.band_id)
  end

  private

  def album_params
    params.require(:album).permit(:band_id, :title, :year, :live)
  end
end