class ImagesController < ApplicationController
  def create
    if image_params.nil?
      flash[:error] = "Image cannot be blank"
      render :new and return
    end

    @image = Image.new(name: params[:name], user_id: current_user.id, url: upload_image_to_cloudinary)
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

  def create_publication(image)
    Publication.create(description: image.name, image: image, user: current_user)
  end

end