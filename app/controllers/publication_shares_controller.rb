class PublicationSharesController < ApplicationController
    def create
        @publication = Publication.new
        @publication.user = current_user
        @publication.description = params[:description]
        if @publication.save
            @publication_shares = PublicationShare.new
            @publication_shares.publication = @publication
            @publication_shares.publicationshare = Publication.find(params[:id])
            @publication_shares.save
        end
    end
end