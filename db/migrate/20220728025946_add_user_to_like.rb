class AddUserToLike < ActiveRecord::Migration[7.0]
  add_column :likes, :user_id, :integer
end