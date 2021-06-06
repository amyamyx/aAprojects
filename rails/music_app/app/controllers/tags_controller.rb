class TagsController < ApplicationController
  def search
    @taggables = Tag.search(params[:search_term], params[:model])

    render :search
  end

  private

  def tag_params
    params.require(:tag).permit(:name, :taggable_type, :taggable_id)
  end
end