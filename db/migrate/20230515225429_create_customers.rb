class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.string :stripe_customer_id
      t.string :name
      t.string :email
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
