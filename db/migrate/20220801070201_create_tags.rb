class CreateTags < ActiveRecord::Migration[7.0]
  def change
    create_table :tags do |t|
      t.string :name
      t.text :description
      t.integer :added_by_id
      t.integer :last_edited_id
      t.integer :tagable_id
      t.string :tagable_type

      t.timestamps
    end
  end
end
