class AddDraftInPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :draft, :boolean, default: false
  end
end
