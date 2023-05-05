class ChangeImageIdInPublications < ActiveRecord::Migration[7.0]
  def change
    change_column :publications, :image_id, :integer, null: true
  end
end
