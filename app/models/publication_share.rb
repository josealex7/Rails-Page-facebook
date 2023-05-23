class PublicationShare < ApplicationRecord
  belongs_to :publication
  belongs_to :publicationshare, class_name: "Publication"

  validates :publication, presence: true
  validates :publicationshare, presence: true

end