class HomeController < ApplicationController
    def index
        @friends = current_user.friends
        @publications = Publication.where(user: [current_user] + @friends).where('created_at >= ?', 3.days.ago).order(created_at: :desc)
        @histories = History.where(user: [current_user] + @friends).where('created_At >= ?', 1.days.ago).order(created_at: :desc)
    end

    def load_more_publications
        @publications = Publication.where(user: [current_user] + @friends).where('created_at >= ?', 3.days.ago).order(created_at: :desc).paginate(page: params[:page], per_page: 10)
        respond_to do |format|
          format.js
        end
    end

    def show_games
        render 'home/videogames'
    end

end