class AddColumnPublications < ActiveRecord::Migration[7.0]
  def change
    create_table :publication_shares do |t|
      t.references :publication, null: false, foreign_key: true
      t.references :publicationshare, references: :publications, foreign_key: { to_table: :publications }
      t.timestamps
    end
  end
end
