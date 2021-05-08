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

  def favorite
    artwork = Artwork.find(params[:id])
    artwork.favorite = true
    if artwork.save
      render json: artwork
    else
      render json: artwork.errors.full_messages, status: :unprocessable_entity
    end
  end

  def unfavorite
    artwork = Artwork.find(params[:id])
    artwork.favorite = false
    if artwork.save
      render json: artwork
    else
      render json: artwork.errors.full_messages, status: :unprocessable_entity
    end
  end

  def like
    artwork = Artwork.find(params[:id])
    like = Like.new({ 
      likable_id: artwork.id,
      likable_type: "Artwork",
      liker_id: params[:liker_id]
    })
    
    if like.save
      render json: artwork
    else
      render json: like.errors.full_messages, status: :unprocessable_entity
    end
  end

  def unlike
    artwork = Artwork.find(params[:id])
    like = Like.find_by({
      likable_id: artwork.id,
      likable_type: "Artwork",
      liker_id: params[:liker_id]
    })

    like.destroy if like
    render json: artwork
  end

  private

  def artwork_params
    params.require(:artwork).permit(:artist_id, :title, :img_url)
  end
end