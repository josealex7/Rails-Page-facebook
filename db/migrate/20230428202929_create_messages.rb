class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.text :message
      t.integer :sender_id, null: false
      t.integer :receiver_id, null: false
      t.timestamps
    end
  end
end
