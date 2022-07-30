class RemoveForeignkeyFromLikesToPost < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :likes, :posts
  end
end
