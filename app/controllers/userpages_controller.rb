class UserpagesController < ApplicationController
    def create
        return false if current_user.user_type == 'page'
        @page = User.new
        @page.first_name = params[:first_name]
        @page.last_name = params[:last_name]
        @page.email = params[:email]
        @page.sex = params[:sex]
        @page.user_type = 'page'
        @page.password = "nopassword"
        if @page.save
            @current_user.pages << @page
            redirect_to switch_user_path(@page)
        end
    #   friend = User.find(params[:friend])
    #   current_user.friendships.build(friend_id: friend.id)
    #   if current_user.save
    #     flash[:notice] = "Following friend"
    #   else
    #     flash[:alert] = "There was something wrong with the tracking request"
    #   end
    #   redirect_to user_path(friend)
    end
  
    def destroy
      friendship = current_user.friendships.where(friend_id: params[:id]).first
      friend = User.find(friendship.friend_id)
      friendship.destroy
      flash[:notice] = "Stopped following"
      redirect_to user_path(friend)
    end
end