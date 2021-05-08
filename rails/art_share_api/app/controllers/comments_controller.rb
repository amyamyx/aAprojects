class CommentsController < ApplicationController
  def index
    if params[:user_id]
      render json: User.find(params[:user_id]).comments
    elsif params[:artwork_id]
      render json: Artwork.find(params[:artwork_id]).comments
    end
  end

  def create
    comment = Comment.new(comment_params)
    if comment.save
      render json: comment
    else
      render json: comment.errors.full_messages, status: :unprocessable_entity
    end
  end
  
  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    render json: comment
  end
  
  def update
    comment = Comment.find(params[:id])
    if comment.update(comment_params)
      render json: comment
    else
      render json: comment.errors.full_messages, status: :unprocessable_entity
    end
  end

  def like
    comment = Comment.find(params[:id])
    like = Like.new({
      likable_id: comment.id,
      likable_type: "Comment",
      liker_id: params[:liker_id]
    })

    if like.save
      render json: comment
    else
      render json: like.errors.full_messages, status: :unprocessable_entity
    end
  end

  def unlike
    comment = Comment.find(params[:id])
    like = Like.find_by({
      likable_id: comment.id,
      likable_type: "Comment",
      liker_id: params[:liker_id]
    })

    like.destroy if like
    render json: comment
  end

  private
  
  def comment_params
    params.require(:comment).permit(:user_id, :artwork_id, :body)
  end
  
end
