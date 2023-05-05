class CreateUserpage < ActiveRecord::Migration[7.0]
  def change
    create_table :userpages do |t|
      t.references :user, null: false, foreign_key: true
      t.references :userpage, references: :users, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
