class HistoriesController < ApplicationController
  def create
    unless params[:image].presence
      flash[:error] = "Image is required"
      return
    end

    @history = History.new(user: current_user, image_url: upload_image_to_cloudinary)
    if @history.save
      respond_to do |format|
        format.js { render :create_success }
      end
    else
      flash[:error] = "Image could not be saved"
      render :new
    end
  end

end