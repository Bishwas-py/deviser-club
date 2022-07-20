class AddImagefieldToQuickTweet < ActiveRecord::Migration[7.0]
  def change
    add_column :quick_tweets, :imagefield, :string
  end
end
