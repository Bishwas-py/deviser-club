class RemoveDraftFromQuickTweets < ActiveRecord::Migration[7.0]
  def change
    remove_column :quick_tweets, :draft, :boolean
  end
end
