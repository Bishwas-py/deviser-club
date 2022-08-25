class CreateDrafts < ActiveRecord::Migration[7.0]
  def change
    create_table :drafts do |t|
      t.integer :draftable_id
      t.string :draftable_type
      t.integer :user_id

      t.timestamps
    end
  end
end
