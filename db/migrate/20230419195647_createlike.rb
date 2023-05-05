class Createlike < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.boolean :is_like
      t.belongs_to :user
      t.belongs_to :publication
    end
  end
end
