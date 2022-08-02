class CreateTags < ActiveRecord::Migration[7.0]
  def change
    create_table :tags do |t|
      t.string :name
      t.text :description
      t.references :created_by, index: true, foreign_key: { to_table: :users }
      t.references :modified_by, index: true, foreign_key: { to_table: :users }, null: true

      t.timestamps
    end
  end
end
