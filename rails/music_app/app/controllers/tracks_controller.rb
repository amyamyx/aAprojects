class TracksController < ApplicationController
  before_action :ensure_logged_in

  def new
    @track = Track.new
    @album = Album.find(params[:album_id])
    @albums = @album.band.albums
  end

  def create
    @track = Track.new(track_params)

    if @track.save
      redirect_to track_url(@track)
    else
      flash[:errors] = @track.errors.full_messages
      redirect_to new_album_track_url(@track.album)
    end
  end

  def edit
    @track = Track.find(params[:id])
    @album = Album.find(@track.album_id)
    @albums = @album.band.albums
  end

  def update
    @track = Track.find(params[:id])

    if @track.update(track_params)
      redirect_to track_url(@track)
    else
      flash[:errors] = @track.errors.full_messages
      redirect_to edit_track_url(@track)
    end
  end

  def show
    @track = Track.find(params[:id])
    @notes = current_user.notes.where(track_id: params[:id]).order(:id)
    @album = @track.album
  end

  def destroy
    track = Track.find(params[:id])
    track.destroy
    redirect_to album_url(track.album_id)
  end

  private
  
  def track_params
    params.require(:track).permit(:title, :ord, :album_id, :lyrics, :bonus)
  end
end