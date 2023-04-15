class CreatePublicationsTable < ActiveRecord::Migration[7.0]
  def change
    create_table :publications do |t|
      t.string :description
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :image
      t.timestamps
    end
  end
end
