class AddColumnProfileImage < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :image_profile_id, :bigint, limit: 20, null: true
    add_index "users", ["image_profile_id"], using: :btree

    add_column :users, :image_portada_id, :bigint, limit: 20, null: true
    add_index "users", ["image_portada_id"], using: :btree
  end
end
