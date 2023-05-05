class CreateMainComments < ActiveRecord::Migration[7.0]
  def change
    create_table :main_comments do |t|
      t.text :text_comment, null: false
      t.belongs_to :publication
      t.belongs_to :user
      t.timestamps
    end
  end
end
