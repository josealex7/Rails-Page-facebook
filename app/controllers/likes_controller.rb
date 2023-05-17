class LikesController < ApplicationController
  def create
    Like.create(is_like: true, user: current_user, publication: Publication.find(params[:id]))
    head :no_content
  end

  def update
    @like = Like.find_by(user_id: current_user.id, publication_id: params[:id])
    @like.update(is_like: !@like.is_like)

    likes_count = Publication.find(params[:id]).likes.where(is_like: true).count
    data = {
      likesCount: likes_count,
      add: @like.is_like,
    }

    render json: data
  end
end