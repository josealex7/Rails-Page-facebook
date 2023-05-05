class MessagesController < ApplicationController
    def create
      return false if params[:message].blank?
      @message = Message.new
      @message.message = params[:message]
      @message.sender = current_user
      @message.receiver_id = params[:receiver_id]
      if @message.save
        @image_url = current_user.image_profile_id ? Image.find(current_user.image_profile_id).url : 'no-image' 
        isSimilar = params[:receiver_id] == current_user.id ? true : false;
        html = message_render(@message)
        ActionCable.server.broadcast("chatfriend_channel", { 
          body: @message.message,
          sender: current_user,
          date_created: @message.created_at.strftime("%b %d, %Y %H:%M:%S"),
          image_url: @image_url,
          html: html
        })
        respond_to do |format|
          format.js
        end
      end
    end
  
    private
  
    def message_params
      params.require(:message).permit(:message)
    end
  
    def message_render(message)
      ApplicationController.render(partial: 'messages/new_message', locals: { message: message })
    end
  
end