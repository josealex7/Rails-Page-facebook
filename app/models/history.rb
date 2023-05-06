class History < ApplicationRecord
    belongs_to :user

    validates :image_url, presence: true
end