class ArtworkSharesController < ApplicationController
  def create
    artwork_share = ArtworkShare.new(share_params)

    if artwork_share.save
      render json: artwork_share
    else
      render json: artwork_share.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    artwork_share = ArtworkShare.find(params[:id])
    artwork_share.destroy
    render json: artwork_share
  end

  private
  
  def share_params
    params.require(:artwork_share).permit(:viewer_id, :artwork_id)
  end
end
