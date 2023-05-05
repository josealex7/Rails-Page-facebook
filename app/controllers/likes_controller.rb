class LikesController < ApplicationController
    def create
        @like = Like.new
        @like.is_like = true
        @like.user = current_user
        @like.publication = Publication.find(params[:id])
        @like.save
        head :no_content
    end

    def update
        @like = Like.find_by(user_id: current_user.id, publication_id: Publication.find(params[:id]))
        @like.update(is_like: !@like.is_like)
        publication = Publication.find(params[:id])

        data = {
            likesCount: publication.likes.where(is_like: true).count,
            add: @like.is_like,
        }

        render json: data
    end
end