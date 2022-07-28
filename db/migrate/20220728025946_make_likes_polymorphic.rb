class MakeLikesPolymorphic < ActiveRecord::Migration[7.0]
  def change
    rename_column :likes, :post_id, :likeable_id  # 1st change
    add_column :likes, :likeable_type, :string  # 3rd change

    remove_index :likes, [:user_id, :likeable_id] # 2st change
    add_index :likes, [:user_id, :likeable_id, :likeable_type], unique: true  # re-add new uniqueness constraint, 4th
    add_index :likes, [:likeable_id, :likeable_type]  # for post.likes.count or comment.likes.count, 5th
  end
end
