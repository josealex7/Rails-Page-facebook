class Message < ApplicationRecord
    belongs_to :sender, class_name: "User"
    belongs_to :receiver, class_name: "User"
  
    validates :message, presence: true
    validates :sender, presence: true
    validates :receiver, presence: true


    def last_message(current_user, user)
        message = Message.where("(sender_id = ? AND receiver_id = ?) OR (sender_id = ? AND receiver_id = ?)", current_user.id, user, user, current_user.id)
    end

end