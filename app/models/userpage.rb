class Userpage < ApplicationRecord
    belongs_to :user
    belongs_to :page, class_name: "User", foreign_key: "userpage_id"
end