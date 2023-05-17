class ChangeColumnUser < ActiveRecord::Migration[7.0]
  def change
    reversible do |dir|
      dir.up do
        change_column :users, :email, :string, null: false, default: ""
      end

      dir.down do
        change_column :users, :email, :string, null: true, default: "page@gmail.com"
      end
    end
  end
end
