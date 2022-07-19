class AddIpFieldToQuickTweet < ActiveRecord::Migration[7.0]
  def change
    add_column :quick_tweets, :ip_field, :string
  end
end
