class AddWatchesToQuickTweet < ActiveRecord::Migration[7.0]
  def change
    add_column :quick_tweets, :watches, :integer, default: 0
  end
end
