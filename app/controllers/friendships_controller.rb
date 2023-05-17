class FriendshipsController < ApplicationController
  def create
    friend = User.find(params[:friend])
    friendship = build_friendship(friend)
    if friendship.persisted?
      flash[:notice] = "Following friend"
    else
      flash[:alert] = "There was something wrong with the tracking request"
    end
    redirect_to user_path(friend)
  end
  
  def destroy
    friend = User.find(params[:id])
    current_user.friendships.where(friend_id: friend.id).destroy_all
    flash[:notice] = "Stopped following"
    redirect_to user_path(friend)
  end

  private

  def build_friendship(friend)
    current_user.friendships.create(friend: friend)
  end
end