class CollectionsController < ApplicationController
  def index
    render json: User.find(params[:user_id]).collections
  end

  def create
    collection = Collection.new(collection_params)
    if collection.save
      render json: collection
    else
      render json: collection.errors.full_messages, status: :unprocessable_entity
    end
  end
  
  def destroy
    collection = Collection.find_by(collection_params)
    collection.destroy
    render json: collection
  end

  def show
    render json: Collection.find(params[:id])
  end

  def add_artwork
    artwork_collection = ArtworkCollection.new({
      collection_id: params[:collection_id],
      artwork_id: params[:artwork_id]
    })

    if artwork_collection.save
      render json: Collection.find(params[:collection_id]).collected_artworks
    else
      render json: artwork_collection.errors.full_messages, status: :unprocessable_entity
    end
  end

  def remove_artwork
    artwork_collection = ArtworkCollection.find_by({
      collection_id: params[:collection_id],
      artwork_id: params[:artwork_id]
    })

    artwork_collection.destroy
    render json: Collection.find(params[:collection_id]).collected_artworks
  end

  private

  def collection_params
    params.require(:collection).permit(:name, :user_id)
  end
end