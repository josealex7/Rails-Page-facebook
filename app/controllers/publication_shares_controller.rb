class PublicationSharesController < ApplicationController
  def create
    @publication = Publication.new(user: current_user, description: params[:description])
    if @publication.save
      PublicationShare.create(publication: @publication, publicationshare: Publication.find(params[:id]))
    end
  end  
end