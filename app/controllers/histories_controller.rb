class HistoriesController < ApplicationController
    # def show
    #     @history = Publication.find(params[:id])
    #     @image = Image.find(@publication.image_id)
    #     @user = User.find(@publication.user_id)
    #     render 'publications/show'
    # end

    def index
        @histories = History.where(user: current_user)
    end

    # def new
    #     @publication = Publication.new
    # end
    
    # def create
    #     @publication = Publication.new
    #     @publication.user_id = current_user.id

    #     if params[:image].present?
    #         image = Image.new(image_params)
    #         image.name = params[:name]
    #         image.user_id = current_user.id
    #         image.url = upload_image_to_cloudinary

    #         if image.save
    #             @publication.image = image
    #             @publication.description = image.name
    #         else
    #             flash[:error] = "Image could not be saved"
    #             render :new and return
    #         end

    #     elsif params[:name].blank?

    #         flash[:error] = "Description or Image is required"
    #         render :new and return

    #     else
    #         @publication.description = params[:name]
    #     end

    #     if @publication.save && params[:image].present?
    #         redirect_to publication_path(@publication.id), notice: 'Publication was successfully created.'
    #     elsif !params[:name].blank?
    #         redirect_to user_path(current_user)
    #     else
    #         render :new
    #     end
    # end


    # def update_description
    #     @publication = Publication.find(params[:publication_id])
    #     @publication.update(description: params[:description])
    #     head :no_content
    # end
    
    # private

    # def image_params
    #     params.require(:image).permit(:name, :url)
    # end

    # def upload_image_to_cloudinary
    #     tempfile = params[:image][:url].tempfile
    #     upload_result = Cloudinary::Uploader.upload(tempfile.path)
    #     upload_result['secure_url']
    # end

end