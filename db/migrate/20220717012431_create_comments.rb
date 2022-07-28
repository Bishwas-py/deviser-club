class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.belongs_to :quick_tweet, null: false, foreign_key: true
      t.timestamps
    end
  end
end
