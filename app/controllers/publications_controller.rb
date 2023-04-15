class PublicationsController < ApplicationController
    def show
        @user = User.find(params[:user_id])
        @image = Image.find(params[:image_id])
        @publication = Publication.where(user_id: @user.id, image_id: @image.id).first
        render 'publications/show', layout: false
    end
end