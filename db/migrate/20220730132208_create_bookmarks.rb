class CreateBookmarks < ActiveRecord::Migration[7.0]
  def change
    create_table :bookmarks do |t|
      t.integer :bookmarkable_id
      t.string :bookmarkable_type
      t.integer :user_id

      t.timestamps
    end
  end
end
