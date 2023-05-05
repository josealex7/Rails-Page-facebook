class MainCommentsController < ApplicationController
    def create
        @comment = MainComment.new
        if !params[:text_comment].blank?
            @comment.text_comment = params[:text_comment]
            @comment.user = current_user
            @comment.publication = Publication.find(params[:id])
            @comment.save
            redirect_to show_publication_path(@comment.publication.user,  image_id: @comment.publication.image_id )
        else
            head :no_content
        end
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