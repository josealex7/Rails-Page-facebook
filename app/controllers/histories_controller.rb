class HistoriesController < ApplicationController
    def create
        @history = History.new
        @history.user = current_user
        if params[:image].present?
            @history.image_url = upload_image_to_cloudinary
            if @history.save
                respond_to do |format|
                    format.js { render :create_success }
                  end
            else
                flash[:error] = "Image could not be saved"
                render :new and return
            end
        else
            flash[:error] = "Description or Image is required"
        end
    end

    def upload_image_to_cloudinary
        tempfile = params[:image][:url].tempfile
        upload_result = Cloudinary::Uploader.upload(tempfile.path)
        upload_result['secure_url']
    end

end