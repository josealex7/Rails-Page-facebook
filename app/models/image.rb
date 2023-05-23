class Image < ApplicationRecord
    belongs_to :user
    has_many :publications

    validates :url, presence: true, format: { without: /\A\s*\z/, message: "can't be blank" }
    validates :url, uniqueness: true
    validates :user_id, presence: true
    validates :url, length: { maximum: 255 }
    validates :url, format: { with: /\.(png|jpe?g|gif)\z/i, message: "must be a URL for a PNG, JPG, or GIF image" }
    validate :check_url_is_image

    private

    def check_url_is_image
        errors.add(:url, "must be a URL for a valid image") unless url.match?(/\Ahttps?:\/\/\S+\.(png|jpe?g|gif)\z/i)
    end
end