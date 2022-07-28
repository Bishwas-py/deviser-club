class MakeCommentsPolymorphic < ActiveRecord::Migration[7.0]
  def change
    rename_column :comments, :quick_tweet_id, :commentable_id  # 1st change
    add_column :comments, :commentable_type, :string  # 3rd change

    remove_index :comments, [:user_id, :commentable_id] # 2st change
    add_index :comments, [:user_id, :commentable_id, :commentable_type], unique: true  # re-add new uniqueness constraint, 4th
    add_index :comments, [:commentable_id, :commentable_type]  # for post.likes.count or comment.likes.count, 5th
  end
end
