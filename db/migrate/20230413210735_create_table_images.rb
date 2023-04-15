class CreateTableImages < ActiveRecord::Migration[7.0]
  def change
    create_table :images do |t|
      t.string :name, null: false, default: ""
      t.string :url, null: false, default: ""
      t.belongs_to :user, index: true, foreign_key: true
      t.timestamps
    end
  end
end
