class AddColumnUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :user_type, :string, null: false, default: "user"

    reversible do |dir|
      dir.up do
        change_column :users, :email, :string, null: false, default: "page@gmail.com"
        change_column :users, :encrypted_password, :string, null: true
      end

      dir.down do
        change_column :users, :email, :string, null: true, default: nil
        change_column :users, :encrypted_password, :string, null: false, default:"nopassword"
      end
    end
  end
end