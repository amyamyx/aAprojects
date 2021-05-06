class ArtworksController < ApplicationController
  def index
    render json: User.find(params[:user_id]).artworks + User.find(params[:user_id]).shared_artworks
  end

  def show
    render json: Artwork.find(params[:id])
  end

  def create
    artwork = Artwork.new(artwork_params)
    if artwork.save
      render json: artwork
    else
      render json: artwork.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    artwork = Artwork.find(params[:id])

    if artwork.update(artwork_params)
      render json: artwork
    else
      render json: artwork.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    artwork = Artwork.find(params[:id])
    artwork.destroy
    render json: artwork
  end

  private

  def artwork_params
    params.require(:artwork).permit(:artist_id, :title, :img_url)
  end
end