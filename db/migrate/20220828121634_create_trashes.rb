class CreateTrashes < ActiveRecord::Migration[7.0]
  def change
    create_table :trashes do |t|
      t.integer :trashable_id
      t.string :trashable_type
      t.integer :user_id

      t.timestamps
    end
  end
end
