class Like < ApplicationRecord
    belongs_to :user
    belongs_to :publication

    validates :is_like, inclusion: { in: [true, false] }
    validates :user_id, presence: true
    validates :publication_id, presence: true
    validates :user_id, uniqueness: { scope: :publication_id }
    

end