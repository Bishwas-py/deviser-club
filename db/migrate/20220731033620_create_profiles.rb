class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    drop_table(:profiles, if_exists: true)
    create_table :profiles do |t|
      t.string :name
      t.string :bio
      t.text :description
      t.integer :user_id

      t.timestamps
    end
  end
end
