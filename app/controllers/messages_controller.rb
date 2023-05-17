class MessagesController < ApplicationController
  def create
    return false if params[:message].blank?
    @message = Message.new(message_params.merge(sender:current_user))
    if @message.save
      @image_url = current_user.image_profile_id ? Image.find(current_user.image_profile_id).url : 'no-image' 
      isSimilar = params[:receiver_id] == current_user.id ? true : false;
      ActionCable.server.broadcast("chatfriend_channel", { 
        body: @message.message,
        sender: current_user,
        image_url: @image_url
      })
    end
  end

  private

  def message_params
    params.permit(:receiver_id, :message)
  end
end