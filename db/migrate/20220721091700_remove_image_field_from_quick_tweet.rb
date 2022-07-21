class RemoveImageFieldFromQuickTweet < ActiveRecord::Migration[7.0]
  def change
    remove_column :quick_tweets, :imagefield, :string
  end
end
