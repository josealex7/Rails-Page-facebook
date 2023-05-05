class CreateHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :histories do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.text :image_url
      t.timestamps
    end
  end
end
