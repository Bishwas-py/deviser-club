class AddDraftInQuickTweets < ActiveRecord::Migration[7.0]
  def change
    add_column :quick_tweets, :draft, :boolean, default: false
  end
end
