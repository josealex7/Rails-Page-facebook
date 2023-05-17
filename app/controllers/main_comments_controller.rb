class MainCommentsController < ApplicationController
  def create
    return head :no_content if params[:text_comment].blank?

    @comment = MainComment.create(text_comment: params[:text_comment], user: current_user, publication_id: params[:id])
    redirect_to publication_path(params[:id])
  end
end