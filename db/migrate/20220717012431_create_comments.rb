class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.integer :comment_id
      t.string :commentable_id
      t.string :commentable_type
      t.string :body

      t.timestamps
    end
  end
end
