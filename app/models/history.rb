class History < ApplicationRecord
    belongs_to :user

    validates :image_url, length: { maximum: 255 }
    validates :image_url, format: { with: /\.(png|jpg|jpeg)\z/i, message: "must be a URL for PNG, JPG or JPEG image" }
    validates :image_url, presence: true
    validates :user_id, presence: true
    
end