class ChatfriendController < ApplicationController
    def index
       @message = Message.new
       @user_friend = User.find(params[:id])
       @messages = Message.where(sender: current_user, receiver: @user_friend)
                                   .or(Message.where(sender: @user_friend, receiver: current_user))
                                   .order(created_at: :asc)
    end
end