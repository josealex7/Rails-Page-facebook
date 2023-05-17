class PublicationsController < ApplicationController
  def show
    @publication = Publication.find(params[:id])
    @image = Image.find(@publication.image_id)
    @user = User.find(@publication.user_id)
    render 'publications/show'
  end
    
  def create
    unless params[:image].present? || params[:name].present?
      flash[:error] = "Description or Image is required"
    end

    @publication = Publication.new(user_id: current_user.id)
    if params[:image].present?
      image = Image.new(name: params[:name], user_id: current_user.id, url: upload_image_to_cloudinary)
      if image.save
        @publication.image = image
        @publication.description = image.name
      else
        flash[:error] = "Image could not be saved"
        render :new and return
      end
    else
      @publication.description = params[:name]
    end

    if @publication.save && params[:image].present?
      redirect_to publication_path(@publication.id), notice: 'Publication was successfully created.'
    elsif !params[:name].blank?
      redirect_to user_path(current_user)
    else
      render :new
    end
  end


  def update_description
    Publication.find(params[:publication_id]).update(description: params[:description])
    head :no_content
  end
    
  private

  def image_params
    params.require(:image).permit(:name, :url)
  end
end