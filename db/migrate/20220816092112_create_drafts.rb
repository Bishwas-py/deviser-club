class CreateDrafts < ActiveRecord::Migration[7.0]
  def change
    create_table :drafts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :draftable, null: false, foreign_key: true
      t.string :draftable_type
      t.string :title

      t.timestamps
    end
  end
end
