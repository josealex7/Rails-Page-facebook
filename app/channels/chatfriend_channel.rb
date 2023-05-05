class ChatfriendChannel < ApplicationCable::Channel
    def subscribed
      stream_from "chatfriend_channel"
    end
  
    def unsubscribed
      # Any cleanup needed when channel is unsubscribed
    end
end