class ImagesController < ApplicationController
    def new
      @image = Image.new
    end
  
    def create
        if image_params.nil?
            flash[:error] = "Image cannot be blank"
            render :new and return
        end

        @image = Image.new(image_params)
        @image.name = params[:name]
        @image.user_id = current_user.id
        @image.url = upload_image_to_cloudinary
        if @image.save
            create_publication(@image)
            redirect_to @image, notice: 'Image was successfully uploaded.'
        else
            render :new
        end
    end
  
    private
  
    def image_params
        params.require(:image).permit(:name, :url)
    end

    def upload_image_to_cloudinary
        tempfile = params[:image][:url].tempfile
        upload_result = Cloudinary::Uploader.upload(tempfile.path)
        upload_result['secure_url']
    end

    def create_publication(image)
        @publication = Publication.new
        @publication.description=image.name
        @publication.image=image
        @publication.user=current_user
        @publication.save
    end

end