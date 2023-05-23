class Message < ApplicationRecord
    belongs_to :sender, class_name: "User"
    belongs_to :receiver, class_name: "User"
    
    validates :message, presence: true, length: { maximum: 1000 }
    validates :sender, presence: true
    validates :receiver, presence: true

    validate :sender_and_receiver_are_different

    def sender_and_receiver_are_different
    errors.add(:base, "El emisor y el receptor no pueden ser el mismo usuario") if sender_id == receiver_id
    end


    def last_message(current_user, user)
        message = Message.where("(sender_id = ? AND receiver_id = ?) OR (sender_id = ? AND receiver_id = ?)", current_user.id, user, user, current_user.id)
    end

end